Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  inspect: [limit: :infinity],
  colors: [
    eval_result: [:cyan, :bright],
    eval_error: [:red, :bright],
    eval_info: [:yellow, :bright],
    syntax_colors: [
      number: :red,
      atom: :blue,
      string: :green,
      boolean: :magenta,
      nil: :magenta,
      list: :white
    ]
  ],
  default_prompt:
    [
      # cursor ⇒ column 1
      "\e[G",
      :cyan,
      "%prefix",
      :yellow,
      "|💧|",
      :cyan,
      "%counter",
      " ",
      :yellow,
      "▶",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)

alias Kanban.Data.{Project, Task, User}
alias Kanban.TaskFSM
