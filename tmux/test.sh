set -e

tmux_conf_theme_status_bg="#080808"
tmux_conf_theme_status_left_fg="#080808,#e4e4e4,#080808"
tmux_conf_theme_status_left_bg="#ffff00,#ff00af,#5fff00"
tmux_conf_theme_status_left_attr="bold,none,none"
tmux_conf_theme_left_separator_main=''
tmux_conf_theme_left_separator_sub='|'

tmux_conf_theme_status_right_fg="#8a8a8a,#e4e4e4,#080808"
tmux_conf_theme_status_right_bg="#080808,#d70000,#e4e4e4"
tmux_conf_theme_status_right_attr="none,none,bold"
tmux_conf_theme_left_separator_main=''
tmux_conf_theme_left_separator_sub='|'

status_left="❐ #S | ↑#{?uptime_y, #{uptime_y}y,}#{?uptime_d, #{uptime_d}d,}#{?uptime_h, #{uptime_h}h,}#{?uptime_m, #{uptime_m}m,}"
status_right=" #{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status, #{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %R , %d %b | #{username}#{root} | #{hostname} "

    status_left=$(printf '%s' "$status_left" | awk \
                      -v status_bg="$tmux_conf_theme_status_bg" \
                      -v fg_="$tmux_conf_theme_status_left_fg" \
                      -v bg_="$tmux_conf_theme_status_left_bg" \
                      -v attr_="$tmux_conf_theme_status_left_attr" \
                      -v mainsep="$tmux_conf_theme_left_separator_main" \
                      -v subsep="$tmux_conf_theme_left_separator_sub" '
      function subsplit(main_section_field_str, num_sub_sections, sub_section_idx, sub_section_array, formatted_main_section)
      {
        num_sub_sections = split(main_section_field_str, sub_section_array, ",")
        for (sub_section_idx = 1; sub_section_idx <= num_sub_sections; ++sub_section_idx)
        {
          o_parens = split(sub_section_array[sub_section_idx], _, "(") - 1
          c_parens = split(sub_section_array[sub_section_idx], _, ")") - 1
          open += o_parens - c_parens
          o_braces = split(sub_section_array[sub_section_idx], _, "{") - 1
          c_braces = split(sub_section_array[sub_section_idx], _, "}") - 1
          open_braces += o_braces - c_braces
          o_brackets = split(sub_section_array[sub_section_idx], _, "[") - 1
          c_brackets = split(sub_section_array[sub_section_idx], _, "]") - 1
          open_brackets += o_brackets - c_brackets

          if (sub_section_idx == num_sub_sections)
            formatted_main_section = sprintf("%s%s", formatted_main_section, sub_section_array[sub_section_idx])
          else if (open_parens || open_braces || open_brackets)
            formatted_main_section = sprintf("%s%s,", formatted_main_section, sub_section_array[sub_section_idx])
          else
            formatted_main_section = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", formatted_main_section, sub_section_array[sub_section_idx], fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg_array[format_idx], bg_array[format_idx], attr_array[format_idx]), formatted_main_section)
        return formatted_main_section
      }
      # Field Separator: "|" (Fields in this case represent the main sections of the tmux status bar)
      # num_formats: min of num_formats_fg, num_formats_bg, num_formats_attr
      BEGIN {
        FS = "|"
        num_formats_fg = split(fg_, fg_array, ",")
        num_formats_bg = split(bg_, bg_array, ",")
        num_formats_attr = split(attr_, attr_array, ",")
        num_formats = num_formats_fg < num_formats_bg ? (num_formats_fg < num_formats_attr ? num_formats_fg : num_formats_attr) : (num_formats_bg < num_formats_attr ? num_formats_bg : num_formats_attr)
      }
      {

        # NF: number of fields in a record
        for (field_idx = format_idx = 1; field_idx <= NF; ++field_idx)
        {
          if (open_parens || open_braces || open_brackets)
            printf "|%s", subsplit($field_idx) # $field_idx is the whole field string at index field_idx
          else
          {
            if (field_idx > 1)
              printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg_array[prev_format_idx], bg_array[format_idx], mainsep, fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsplit($field_idx)
            else
              printf "#[fg=%s,bg=%s,%s]%s", fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsplit($field_idx)
          }

          if (!open_parens && !open_braces && !open_brackets)
          {
            prev_format_idx = format_idx
            format_idx = format_idx % num_formats + 1
          }
        }
        printf "#[fg=%s,bg=%s,none]%s", bg_array[prev_format_idx], status_bg, mainsep
      }')

    status_right=$(printf '%s' "$status_right" | awk \
                      -v status_bg="$tmux_conf_theme_status_bg" \
                      -v fg_="$tmux_conf_theme_status_right_fg" \
                      -v bg_="$tmux_conf_theme_status_right_bg" \
                      -v attr_="$tmux_conf_theme_status_right_attr" \
                      -v mainsep="$tmux_conf_theme_right_separator_main" \
                      -v subsep="$tmux_conf_theme_right_separator_sub" '
      function subsplit(main_section_field_str, num_sub_sections, sub_section_idx, sub_section_array, formatted_main_section)
      {
        num_sub_sections = split(main_section_field_str, sub_section_array, ",")
        for (sub_section_idx = 1; sub_section_idx <= num_sub_sections; ++sub_section_idx)
        {
          o_parens = split(sub_section_array[sub_section_idx], _, "(") - 1
          c_parens = split(sub_section_array[sub_section_idx], _, ")") - 1
          open += o_parens - c_parens
          o_braces = split(sub_section_array[sub_section_idx], _, "{") - 1
          c_braces = split(sub_section_array[sub_section_idx], _, "}") - 1
          open_braces += o_braces - c_braces
          o_brackets = split(sub_section_array[sub_section_idx], _, "[") - 1
          c_brackets = split(sub_section_array[sub_section_idx], _, "]") - 1
          open_brackets += o_brackets - c_brackets

          if (sub_section_idx == num_sub_sections)
            formatted_main_section = sprintf("%s%s", formatted_main_section, sub_section_array[sub_section_idx])
          else if (open_parens || open_braces || open_brackets)
            formatted_main_section = sprintf("%s%s,", formatted_main_section, sub_section_array[sub_section_idx])
          else
            formatted_main_section = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", formatted_main_section, sub_section_array[sub_section_idx], fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg_array[format_idx], bg_array[format_idx], attr_array[format_idx]), formatted_main_section)
        return formatted_main_section
      }
      # Field Separator: "|" (Fields in this case represent the main sections of the tmux status bar)
      # num_formats: min of num_formats_fg, num_formats_bg, num_formats_attr
      BEGIN {
        FS = "|"
        num_formats_fg = split(fg_, fg_array, ",")
        num_formats_bg = split(bg_, bg_array, ",")
        num_formats_attr = split(attr_, attr_array, ",")
        num_formats = num_formats_fg < num_formats_bg ? (num_formats_fg < num_formats_attr ? num_formats_fg : num_formats_attr) : (num_formats_bg < num_formats_attr ? num_formats_bg : num_formats_attr)
      }
      {
        # NF: number of fields in a record
        for (field_idx = format_idx = 1; field_idx <= NF; ++field_idx)
        {
          if (open_parens || open_braces || open_brackets)
            printf "|%s", subsplit($field_idx) # $field_idx is the whole field string at index field_idx
          else
            printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg_array[format_idx], (field_idx == 1) ? status_bg : bg_array[prev_format_idx], mainsep, fg_array[format_idx], bg_array[format_idx], attr_array[format_idx], subsplit($field_idx)

          if (!open_parens && !open_braces && !open_brackets)
          {
            prev_format_idx = format_idx
            format_idx = format_idx % num_formats + 1
          }
        }
      }')
#status_left_theirs=$(printf '%s' "$status_left" | awk \
#                  -v status_bg="$tmux_conf_theme_status_bg" \
#                  -v fg_="$tmux_conf_theme_status_left_fg" \
#                  -v bg_="$tmux_conf_theme_status_left_bg" \
#                  -v attr_="$tmux_conf_theme_status_left_attr" \
#                  -v mainsep="$tmux_conf_theme_left_separator_main" \
#                  -v subsep="$tmux_conf_theme_left_separator_sub" '
#  function subsplit(s, l, i, a, r)
#  {
#    l = split(s, a, ",")
#    for (i = 1; i <= l; ++i)
#    {
#      o = split(a[i], _, "(") - 1
#      c = split(a[i], _, ")") - 1
#      open += o - c
#      o_ = split(a[i], _, "{") - 1
#      c_ = split(a[i], _, "}") - 1
#      open_ += o_ - c_
#      o__ = split(a[i], _, "[") - 1
#      c__ = split(a[i], _, "]") - 1
#      open__ += o__ - c__
#
#      if (i == l)
#        r = sprintf("%s%s", r, a[i])
#      else if (open || open_ || open__)
#        r = sprintf("%s%s,", r, a[i])
#      else
#        r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
#    }
#
#    gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
#    return r
#  }
#  BEGIN {
#    FS = "|"
#    l1 = split(fg_, fg, ",")
#    l2 = split(bg_, bg, ",")
#    l3 = split(attr_, attr, ",")
#    l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
#  }
#  {
#    for (i = j = 1; i <= NF; ++i)
#    {
#      if (open || open_ || open__)
#        printf "|%s", subsplit($i)
#      else
#      {
#        if (i > 1)
#          printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j_], bg[j], mainsep, fg[j], bg[j], attr[j], subsplit($i)
#        else
#          printf "#[fg=%s,bg=%s,%s]%s", fg[j], bg[j], attr[j], subsplit($i)
#      }
#
#      if (!open && !open_ && !open__)
#      {
#        j_ = j
#        j = j % l + 1
#      }
#    }
#    printf "#[fg=%s,bg=%s,none]%s", bg[j_], status_bg, mainsep
#  }')

status_right_theirs=$(printf '%s' "$status_right" | awk \
                  -v status_bg="$tmux_conf_theme_status_bg" \
                  -v fg_="$tmux_conf_theme_status_right_fg" \
                  -v bg_="$tmux_conf_theme_status_right_bg" \
                  -v attr_="$tmux_conf_theme_status_right_attr" \
                  -v mainsep="$tmux_conf_theme_right_separator_main" \
                  -v subsep="$tmux_conf_theme_right_separator_sub" '
  function subsplit(s, l, i, a, r)
  {
    l = split(s, a, ",")
    for (i = 1; i <= l; ++i)
    {
      o = split(a[i], _, "(") - 1
      c = split(a[i], _, ")") - 1
      open += o - c
      o_ = split(a[i], _, "{") - 1
      c_ = split(a[i], _, "}") - 1
      open_ += o_ - c_
      o__ = split(a[i], _, "[") - 1
      c__ = split(a[i], _, "]") - 1
      open__ += o__ - c__

      if (i == l)
        r = sprintf("%s%s", r, a[i])
      else if (open || open_ || open__)
        r = sprintf("%s%s,", r, a[i])
      else
        r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
    }

    gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
    return r
  }
  BEGIN {
    FS = "|"
    l1 = split(fg_, fg, ",")
    l2 = split(bg_, bg, ",")
    l3 = split(attr_, attr, ",")
    l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
  }
  {
    for (i = j = 1; i <= NF; ++i)
    {
      if (open_ || open || open__)
        printf "|%s", subsplit($i)
      else
        printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j], (i == 1) ? status_bg : bg[j_], mainsep, fg[j], bg[j], attr[j], subsplit($i)

      if (!open && !open_ && !open__)
      {
        j_ = j
        j = j % l + 1
      }
    }
  }')

#echo $status_left_theirs
#echo $status_left_mine
echo $status_right_theirs
echo $status_right_mine
