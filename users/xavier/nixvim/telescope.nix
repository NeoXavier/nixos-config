{pkgs, ...}: {
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>?" = {
        action = "oldfiles";
        desc = "[?] Find recently opened files";
      };
      "<leader><space>" = {
        action = "buffers";
        desc = "[ ] Find existing buffers";
      };
      "<leader>/" = {
        action = "current_buffer_fuzzy_find";
        desc = "[/] Fuzzily search in current buffer]";
      };
      "<leader>ff" = {
        action = "find_files";
        desc = "[f]find [f]iles";
      };
      "<leader>sh" = {
        action = "help_tags";
        desc = "[s]earch [h]elp";
      };
      "<leader>sw" = {
        action = "grep_string";
        desc = "[s]earch current [w]ord";
      };
      "<leader>lg" = {
        action = "live_grep";
        desc = "[l]ive [g]rep";
      };
      "<leader>sd" = {
        action = "diagnostics";
        desc = "[s]earch [d]iagnotics";
      };
      "<leader>sk" = {
        action = "keymaps";
        desc = "[s]earch [k]eymaps";
      };
    };
  };
}
