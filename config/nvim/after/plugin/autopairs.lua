local autopairs_available, npairs = pcall(require, "nvim-autopairs")

if autopairs_available then
  local Rule = require('nvim-autopairs.rule')

  npairs.setup({
    check_ts = true, -- treesitter
    ts_config = {
      lua = { "string" }, -- will not add a pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  })


  local ts_conds_available, ts_conds = pcall(require, 'nvim-autopairs.ts-conds')

  if ts_conds_available then
    -- press % => %% only while inside a comment or string
    npairs.add_rules({
      Rule("%", "%", "lua")
        :with_pair(ts_conds.is_ts_node({'string','comment'})),
      Rule("$", "$", "lua")
        :with_pair(ts_conds.is_not_ts_node({'function'}))
    })
  end

  local cond = require('nvim-autopairs.conds')

  npairs.add_rules({
    Rule("$", "$",{"tex", "latex"})
      -- don't add a pair if the next character is %
      :with_pair(cond.not_after_regex("%%"))
      -- don't add a pair if  the previous character is xxx
      :with_pair(cond.not_before_regex("xxx", 3))
      -- don't move right when repeat character
      :with_move(cond.none())
      -- don't delete if the next character is xx
      :with_del(cond.not_after_regex("xx"))
      -- disable adding a newline when you press <cr>
      :with_cr(cond.none())
  },
    -- disable for .vim files, but it works for another filetypes
    Rule("a","a","-vim")
  )

  npairs.add_rules({
    Rule("$$","$$","tex")
      :with_pair(function(opts)
        print(vim.inspect(opts))
        if opts.line=="aa $$" then
          -- don't add pair on that line
          return false
        end
      end)
  })

end
