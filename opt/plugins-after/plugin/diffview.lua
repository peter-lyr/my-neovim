local status1, diffview = pcall(require, "diffview")
if not status1 then
  return
end

local status2, actions = pcall(require, "diffview.actions")
if not status2 then
  return
end

diffview.setup({
  diff_binaries = false,
  icons = {
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  file_panel = {
    win_config = {
      position = "right",
    },
  },
  file_history_panel = {
    log_options = {
      git = {
        single_file = {
          diff_merges = "combined",
          max_count = 8,
        },
        multi_file = {
          diff_merges = "first-parent",
          max_count = 8,
        },
      },
      hg = {
        single_file = {},
        multi_file = {},
      },
    },
    win_config = {
      position = "bottom",
      height = 16,
      win_opts = {}
    },
  },
  keymaps = {
    disable_defaults = true,
    view = {
      { "n", "<tab>",      actions.select_next_entry,          { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",    actions.select_prev_entry,          { desc = "Open the diff for the previous file" } },
      { "n", "gf",         actions.goto_file,                  { desc = "Open the file in a new split in the previous tabpage" } },
      { "n", "F",          actions.goto_file_split,            { desc = "Open the file in a new split" } },
      { "n", "gF",         actions.goto_file_tab,              { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",  actions.focus_files,                { desc = "Bring focus to the file panel" } },
      { "n", "<leader>l",  actions.toggle_files,               { desc = "Toggle the file panel." } },
      { "n", "<A-x>",      actions.cycle_layout,               { desc = "Cycle through available layouts." } },
      { "n", "[x",         actions.prev_conflict,              { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",         actions.next_conflict,              { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co", actions.conflict_choose("ours"),    { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct", actions.conflict_choose("theirs"),  { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb", actions.conflict_choose("base"),    { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca", actions.conflict_choose("all"),     { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",         actions.conflict_choose("none"),    { desc = "Delete the conflict region" } },
    },
    diff1 = {
      { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "?",    actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
    },
    diff4 = {
      { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "?",    actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",             actions.next_entry,           { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,           { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,           { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          actions.prev_entry,           { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<cr>",          actions.select_entry,         { desc = "Open the diff for the selected entry." } },
      { "n", "o",             actions.select_entry,         { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", actions.select_entry,         { desc = "Open the diff for the selected entry." } },
      { "n", "s",             actions.toggle_stage_entry,   { desc = "Stage / unstage the selected entry." } },
      { "n", "S",             actions.stage_all,            { desc = "Stage all entries." } },
      { "n", "U",             actions.unstage_all,          { desc = "Unstage all entries." } },
      { "n", "X",             actions.restore_entry,        { desc = "Restore entry to the state on the left side." } },
      { "n", "L",             actions.open_commit_log,      { desc = "Open the commit log panel." } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),   { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),    { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,    { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,    { desc = "Open the diff for the previous file" } },
      { "n", "gf",            actions.goto_file,            { desc = "Open the file in a new split in the previous tabpage" } },
      { "n", "F",             actions.goto_file_split,      { desc = "Open the file in a new split" } },
      { "n", "gF",            actions.goto_file_tab,        { desc = "Open the file in a new tabpage" } },
      { "n", "i",             actions.listing_style,        { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",             actions.toggle_flatten_dirs,  { desc = "Flatten empty subdirectories in tree listing style." } },
      { "n", "R",             actions.refresh_files,        { desc = "Update stats and entries in the file list." } },
      { "n", "<leader>e",     actions.focus_files,          { desc = "Bring focus to the file panel" } },
      { "n", "<leader>l",     actions.toggle_files,         { desc = "Toggle the file panel" } },
      { "n", "<A-x>",         actions.cycle_layout,         { desc = "Cycle available layouts" } },
      { "n", "[x",            actions.prev_conflict,        { desc = "Go to the previous conflict" } },
      { "n", "]x",            actions.next_conflict,        { desc = "Go to the next conflict" } },
      { "n", "?",             actions.help("file_panel"),   { desc = "Open the help panel" } },
    },
    file_history_panel = {
      { "n", "!",             actions.options,                     { desc = "Open the option panel" } },
      { "n", "D",             actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
      { "n", "r",             actions.open_all_folds,              { desc = "Expand all folds" } },
      { "n", "m",             actions.close_all_folds,             { desc = "Collapse all folds" } },
      { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
      { "n", "gf",            actions.goto_file,                   { desc = "Open the file in a new split in the previous tabpage" } },
      { "n", "F",             actions.goto_file_split,             { desc = "Open the file in a new split" } },
      { "n", "gF",            actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
      { "n", "<leader>l",     actions.toggle_files,                { desc = "Toggle the file panel" } },
      { "n", "<A-x>",         actions.cycle_layout,                { desc = "Cycle available layouts" } },
      { "n", "?",             actions.help("file_history_panel"),  { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", actions.select_entry,          { desc = "Change the current option" } },
      { "n", "q",     actions.close,                 { desc = "Close the panel" } },
      { "n", "?",     actions.help("option_panel"),  { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     actions.close,  { desc = "Close help menu" } },
      { "n", "<esc>", actions.close,  { desc = "Close help menu" } },
      { "n", "<leader>w", actions.close,  { desc = "Close help menu" } },
      { "n", "<leader>s", actions.close,  { desc = "Close help menu" } },
      { "n", "<leader>a", actions.close,  { desc = "Close help menu" } },
      { "n", "<leader>d", actions.close,  { desc = "Close help menu" } },
    },
  },
})
