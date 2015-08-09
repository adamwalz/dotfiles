#------------------------------------------------------------------------------
#          FILE:  Rakefile
#   DESCRIPTION:  Installs and uninstalls dot configuaration files.
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  1.1.1
#------------------------------------------------------------------------------

require 'date'
require 'open3'
require 'fileutils'
require 'erb'

RAW_FILE_EXTENSION = 'rrc'
RAW_FILE_EXTENSION_REGEXP = /\.#{RAW_FILE_EXTENSION}$/

KEYCHAIN_GENERIC_PASSWORD_COMMAND = 'security find-generic-password -gl'
KEYCHAIN_INTERNET_PASSWORD_COMMAND = 'security find-internet-password -gl'
ACCOUNT_REGEXP = /"acct"<blob>=(?:0x([0-9A-F]+)\s*)?(?:"(.*)")?$/
PASSWORD_REGEXP = /^password: (?:0x([0-9A-F]+)\s*)?(?:"(.*)")?$/

SCRIPT_PATH = File.split(File.expand_path(__FILE__))
SCRIPT_NAME = SCRIPT_PATH.last
CONFIG_DIR_PATH = SCRIPT_PATH.first

SUBLIME_DIR_PATH = File.join("#{CONFIG_DIR_PATH}", 'sublime')

BACKUP_DIR_PATH = File.join(ENV['HOME'], '.dotfiles_backup',
  DateTime.now.strftime('%Y-%m-%d-%H-%M-%S'))

EXCLUDES = [
  SCRIPT_NAME,
  'LICENSE',
  '.DS_Store',
  '.git',
  '.gitignore',
  '.gitmodules',
  'install.sh',
  'brew',
  'sublime',
  'iterm2',
  'pythons' ,
  'README.md',
  /.*~$/,
  /^\#.*\#$/,
  /backup\/.*$/,
]

# Utility function for displaying messages.
def info(text)
  STDOUT.puts text
end

# Utility function for displaying warning messages.
def warn(text)
  begin
    require 'colorize'
    STDOUT.puts "Warning".yellow.underline + ": #{text}".yellow
  rescue LoadError
    STDOUT.puts "Warning: #{text}"
  end
end

# Utility function for displaying error messages.
def error(text)
  begin
    require 'colorize'
    STDERR.puts "Error".red.underline + ": #{text}".red
  rescue LoadError
    STDERR.puts "Error: #{text}"
  end
end

class Platform
  def self.mac?
    RUBY_PLATFORM.include? 'darwin'
  end

  def self.linux?
    RUBY_PLATFORM.include? 'linux'
  end

  def self.windows?
  RUBY_PLATFORM.include? 'windows'
  end
end

def sublime_package_path
  if Platform.mac?
    "#{ENV['HOME']}/Library/Application Support/Sublime Text 3/Packages"
  elsif Platform.linux?
    "#{ENV['HOME']}/.Sublime Text 3/Packages"
  else
    "#{ENV['APPDATA']}\\Sublime Text 3/Packages"
  end
end

# Returns whether a path is excluded from linking into the home directory.
#
# @param [String] path the path a to file or directory.
# @return [true, false] if true, the path is excluded; otherwise, it is not.
def excluded?(path)
  strings = EXCLUDES.select { |item| item.class == String }
  regexps = EXCLUDES.select { |item| item.class == Regexp }
  excluded = strings.include? path
  regexps.each do |pattern|
    excluded = true if path =~ pattern
  end
  return excluded
end

# Moves an existing dot file into the backup directory.
#
# @param [String] from the file to back up.
# @param [String] to the backup destination.
def backup(from, to)
  return unless File.exists? from
  info "Backing up old version of #{File.basename(from)}"
  FileUtils.mkdir_p(File.dirname(to))
  File.rename(from, to)
end

# Returns whether a command exists in PATH.
#
# @param [String] command the name of the command.
# @return [true, false] if true, the command exists; otherwise, it does not.
def command?(command)
  ENV['PATH'].split(':').any? do |directory|
    File.exists?(File.join(directory, command))
  end
end

# Raised when a Keychain item is not found.
class KeychainError < Exception
end

# Wrapper around OS X Keychain.
module Keychain
  # Holds previously requested Keychain items.
  @@cache = {}

  # Wrapper around a Keychain item.
  class Item
    # Returns the accout name.
    attr_reader :account
    # Returns the account password.
    attr_reader :password

    # Returns a new Keychain item.
    #
    # @param [String] account the account name.
    # @param [String] password the account password.
    # @return [Item] the Keychain item.
    def initialize(account, password)
      @account = account or raise ArgumentError, "Account cannot be nil"
      @password = password or raise ArgumentError, "Password cannot be nil"
    end
  end

  # Returns a Keychain item.
  #
  # @param [String] label the Keychain item label.
  # @return [Item] the Keychain item.
  def self.[](label)
    return @@cache[label] if @@cache.has_key? label
    retry_times = 2
    keychain_command = KEYCHAIN_INTERNET_PASSWORD_COMMAND
    begin
      stdin, stdout, stderr = Open3.popen3("#{keychain_command} '#{label}'")
      output = stdout.readlines.join + stderr.readlines.join
      [stdin, stdout, stderr].each { |stdio| stdio.close }
      if output =~ /The specified item could not be found in Keychain\./
        raise NameError
      end
      # The field value is stored in hexademical (one) or string (two).
      field_value = lambda do |one, two|
        return one.scan(/../).map { |tuple| tuple.hex.chr }.join unless one.nil?
        return two unless two.nil?
        return ""
      end
      account = output[ACCOUNT_REGEXP].gsub!(ACCOUNT_REGEXP) { field_value[$1, $2] }
      password = output[PASSWORD_REGEXP].gsub!(PASSWORD_REGEXP) { field_value[$1, $2] }
      @@cache[label] = Item.new(account, password)
    rescue NameError
      keychain_command = KEYCHAIN_GENERIC_PASSWORD_COMMAND
      retry_times -= 1
      if retry_times > 0
        retry
      else
        raise KeychainError, "Item '#{label}' could not be found in Keychain"
      end
    rescue IOError
      raise KeychainError, "Could not communicate with Keychain for item '#{label}'"
    end
  end
end

# Do stuff in parallel
module Enumerable
  def in_parallel
    map{|x| Thread.new do
        Thread.current.abort_on_exception = true
        yield(x)
      end
    }.each do |t|
      begin
        t.join
      rescue Exception => e
        error e.message if e.class == IOError
      end
    end
  end
end

namespace :dotfiles do
  task :install => [:render, :link, :clean]

  multitask :link => [:link_dotfiles, :link_sublime]

  task :link_dotfiles do
    Dir["#{CONFIG_DIR_PATH}/*"].each do |source|
      next if ((source =~ /#{CONFIG_DIR_PATH}\/mac-.+/ and not Platform.mac?) \
            or (source =~ /#{CONFIG_DIR_PATH}\/linux-.+/ and not Platform.linux?) \
            or (source =~ /#{CONFIG_DIR_PATH}\/windows-.+/ and not Platform.windows?))

      # Remove platform specifier from dotfile
      target_relative = File.basename(source).gsub(/^(mac|windows|linux)-/, '')

      target_backup = File.join(BACKUP_DIR_PATH, target_relative)
      target = File.join(ENV['HOME'], ".#{target_relative}")
      # Do not link if the source is a raw file, the target already exists and
      # is a symlink to the source.
      next if source =~ RAW_FILE_EXTENSION_REGEXP \
      or excluded?(target_relative) \
      or (File.exists?(target) \
        and File.ftype(target) == 'link' \
        and File.identical?(source, target))
      link_and_backup(source, target, target_backup)
    end
  end

   task :link_sublime do
    PLATFORM_PREF_REGEX = /^Preferences \((OSX|Windows|Linux)\)\.sublime-settings$/
    Dir["#{SUBLIME_DIR_PATH}/*"].each do |source|
      target_relative = File.basename(source)
      target_backup = File.join(BACKUP_DIR_PATH, target_relative)

      preference_type = target_relative =~ PLATFORM_PREF_REGEX ? 'Default' : 'User'
      target = File.join(sublime_package_path, preference_type, target_relative)

      next if (File.exists?(target) \
        and File.ftype(target) == 'link' \
        and (File.identical?(source, target) \
          or (File.mtime(target) > File.mtime(source))))
      link_and_backup(source, target, target_backup)
    end
  end

  desc 'Render raw dot files'
  task :render do
    Dir["#{CONFIG_DIR_PATH}/**/*.#{RAW_FILE_EXTENSION}"].each do |source|
      target = source.gsub(RAW_FILE_EXTENSION_REGEXP, '')
      next if excluded? source
      if File.file? source
        begin
          source_contents = File.read source
          source_contents = ERB.new(source_contents).result(binding)
        rescue IOError
          error "Could not read raw file '#{source}'"
        rescue NameError, SyntaxError => e
          error "Could not render raw file '#{source}'.\n\n#{e.message}"
        rescue KeychainError => e
          error e.message
        end
        begin
          target_contents = File.exists?(target) ? File.read(target) : nil
          # Only overwrite the rendered dot file if the raw file has changed.
          if source_contents != target_contents
            File.open(target, 'w') do |file|
              info "Writing: #{target}"
              file.write source_contents
              file.chmod 0600
            end
          end
        rescue IOError
          error "Could not write file '#{target}'"
        end
      end
    end
  end

  multitask :unlink => [:unlink_dotfiles, :unlink_sublime]

  task :unlink_dotfiles do
    # unlink dotfiles from home directory
    Dir["#{CONFIG_DIR_PATH}/*"].each do |source|
      next if ((source =~ /#{CONFIG_DIR_PATH}\/mac-.+/ and not Platform.mac?) \
            or (source =~ /#{CONFIG_DIR_PATH}\/linux-.+/ and not Platform.linux?) \
            or (source =~ /#{CONFIG_DIR_PATH}\/windows-.+/ and not Platform.windows?))

      # Remove platform specifier from dotfile
      link_relative = File.basename(source).gsub(/^(mac|windows|linux)-/, '')

      link = File.join(ENV['HOME'], ".#{link_relative}")
      next if source =~ RAW_FILE_EXTENSION_REGEXP or excluded?(link_relative)
      unlink(link)
    end
  end

  task :unlink_sublime do
    Dir["#{sublime_package_path}/**/*"].each do |symlink|
      link_relative = File.basename(symlink)
      next if symlink =~ RAW_FILE_EXTENSION_REGEXP or excluded?(link_relative)
      unlink symlink
    end
  end

  task :clean do
    # Must clean entire home directory instead of only the dotfiles that this
    # script symlinked because if the link is broken that means that it is no
    # longer in CONFIG_DIR_PATH
    Dir["#{ENV['HOME']}/.*"].each do |item|
      unlink_if_broken item
    end
    Dir["#{sublime_package_path}/*"].each do |item|
      unlink_if_broken item
    end
  end

  def link_and_backup(source, target, backup)
    info "Linking: #{target}"
    begin
      backup target, backup
    rescue Error
      error "Could not backup '#{target}, will skip symlinking '#{source}'"
      return
    end

    FileUtils.mkdir_p File.dirname(target)
    begin
      File.symlink source, target
    rescue NotImplementedError
      error "Cannot create a symlink on #{RUBY_PLATFORM}"
    end
  end

  def unlink(file)
    begin
      if File.ftype(file) == 'link'
        info "Unlinking: #{file}"
        File.unlink file
      end
    rescue IOError
      error "Could not unlink '#{file}'"
    rescue Exception
      return
    end
  end

  def unlink_if_broken(file)
    begin
      if (File.ftype(file) == 'link' and not File.exists?(file))
        unlink file
      end
    rescue IOError
      error "Could not unlink '#{file}'"
    rescue Exception
      return
    end
  end

end

desc 'Renders, links, and cleans dotfiles'
task :install => [ 'dotfiles:install' ] do
  # Note: this task previously also ran gitmodules:init and gitmodules:make
  # but these subtasks were removed because they weren't used. Add them
  # back if there becomes a point where gitmodules are necessary
  info "Backup: #{BACKUP_DIR_PATH}" if File.directory? BACKUP_DIR_PATH
end

desc 'Uninstall dot files'
task :uninstall => [ 'dotfiles:unlink', 'dotfiles:clean' ]

desc 'Unlink broken symlinks in home directory'
task :clean => [ 'dotfiles:clean' ]

task :default => [:install]
