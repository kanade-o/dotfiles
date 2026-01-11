return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
    },
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
      require("CopilotChat").setup({
        model = "gpt-5-mini",
        temperature = 0.1,
        show_help = true,
        system_prompt = [[
            あなたは経験豊富なシニアプログラマーです。
            以下のルールに従って回答してください：
            1. すべての説明は日本語で行う
            2. コード内のコメントも日本語で記述する
            3. 技術用語は必要に応じて英語併記する
            4. コードは実践的で本番環境で使用できる品質にする
            5. ベストプラクティスとデザインパターンを適用する  
        ]],
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
            --mapping = "<leader>ce",
            description = "コードの説明をお願いする",
          },
          Review = {
            prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
            --mapping = "<leader>cr",
            description = "コードのレビューをお願いする",
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
            --mapping = "<leader>cf",
            description = "コードの修正をお願いする",
          },
          Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
            --mapping = "<leader>co",
            description = "コードの最適化をお願いする",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
            --mapping = "<leader>cd",
            description = "コードのドキュメント作成をお願いする",
          },
          Tests = {
            prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
            --mapping = "<leader>ct",
            description = "テストコード作成をお願いする",
          },
          FixDiagnostic = {
            prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
            --mapping = "<leader>cd",
            description = "コードの修正をお願いする",
            selection = require("CopilotChat.select").diagnostics,
          },
          Commit = {
            prompt = "実装差分に対するコミットメッセージを日本語で記述してください。",
            --mapping = "<leader>cco",
            description = "コミットメッセージの作成をお願いする",
            selection = require("CopilotChat.select").gitdiff,
          },
          CommitStaged = {
            prompt = "ステージ済みの変更に対するコミットメッセージを日本語で記述してください。",
            --mapping = "<leader>cs",
            description = "ステージ済みのコミットメッセージの作成をお願いする",
            selection = function(source)
              return require("CopilotChat.select").gitdiff(source, true)
            end,
          },
        },
      })

      -- バッファ全体を対象に日本語で質問
      function CopilotChatAsk(prompt_prefix, prompt_suffix)
        local prompt = prompt_prefix .. (prompt_suffix or "")
        require("CopilotChat").ask(prompt, {
          selection = require("CopilotChat.select").buffer,
        })
      end

      -- 複数バッファを対象に質問
      function CopilotChatAskMultiple(prompt)
        local full_prompt = prompt .. "\n\n#buffers"
        require("CopilotChat").ask(full_prompt, {
          selection = require("CopilotChat.select").buffers,
        })
      end

      -- カスタム入力を受け付ける関数
      function CopilotChatWithInput(prompt_text, use_multiple_buffers)
        local input = vim.fn.input(prompt_text .. ": ")
        if input ~= "" then
          if use_multiple_buffers then
            CopilotChatAskMultiple(input)
          else
            CopilotChatAsk(input)
          end
        end
      end
    end,
  },
}
