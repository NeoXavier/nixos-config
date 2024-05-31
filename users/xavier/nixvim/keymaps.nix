{pkgs, ...}: {
  keymaps = [
    {
      key = "<C-d>";
      mode = "n";
      action = "<C-d>zz"; # Keep cursor in middle
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<C-u>";
      mode = "n";
      action = "<C-u>zz"; # Keep cursor in middle
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "J";
      mode = "v";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Shift line down 1 in visual mode";
      };
    }
    {
      key = "K";
      mode = "v";
      action = ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Shift line up 1 in visual mode";
      };
    }
    {
      key = "J";
      mode = "n";
      action = "mzJ\`z"; # Keep cursor to the left
      options = {
        silent = true;
        noremap = true;
        desc = "Join without moving cursor";
      };
    }
    {
      key = "n";
      mode = "n";
      action = "nzzzv"; # Keep cursor in middle
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "N";
      mode = "n";
      action = "Nzzzv";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>p";
      mode = "x";
      action = "\"_dP";
      options = {
        silent = true;
        noremap = true;
        desc = "Paste, removed text goes into void register";
      };
    }
    {
      key = "<leader>d";
      mode = ["n" "v"];
      action = "\"_dP";
      options = {
        silent = true;
        noremap = true;
        desc = "Delete to void register";
      };
    }
    {
      key = "<leader>y";
      mode = ["n" "v"];
      action = "\"+y";
      options = {
        silent = true;
        noremap = true;
        desc = "[y]ank to system clipboard";
      };
    }
    {
      key = "<leader>Y";
      mode = "n";
      action = "\"+Y";
      options = {
        silent = true;
        noremap = true;
        desc = "[Y]ank line to system clipboard";
      };
    }
    {
      key = "Q";
      mode = "n";
      action = "<nop>";
      options = {
        silent = true;
        noremap = true;
        desc = "Don't";
      };
    }
    {
      key = "<leader>s";
      mode = "n";
      action = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
      options = {
        silent = true;
        noremap = true;
        desc = "Replace current word";
      };
    }
    {
      key = "<C-w><Bar>";
      mode = "n";
      action = ":vsplit<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Split windows vertically";
      };
    }
    {
      key = "<C-w>_";
      mode = "n";
      action = ":split<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Split windows horizontally";
      };
    }
    {
      key = "<leader><Tab>";
      mode = "n";
      action = "<cmd>bn<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Next Buffer";
      };
    }
    {
      key = "<leader><S-Tab>";
      mode = "n";
      action = "<cmd>bp<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Prev Buffer";
      };
    }
    {
      key = "<leader>o";
      mode = "n";
      action = "<CMD>q<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Open netrw";
      };
    }
    {
      key = "<leader>gs";
      mode = "n";
      action = "<CMD>Git<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Fugitive";
      };
    }
    {
      key = "<leader>u";
      mode = "n";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "[u]ndotree toggle";
      };
    }
    {
      key = "<C-k>";
      mode = "n";
      action = "<cmd>cnext<CR>zz";
      options = {
        silent = true;
        noremap = true;
        desc = "Next quickfix";
      };
    }
    {
      key = "<C-j>";
      mode = "n";
      action = "<cmd>cprev<CR>zz";
      options = {
        silent = true;
        noremap = true;
        desc = "Prev quickfix";
      };
    }
    {
      key = "]d";
      mode = "n";
      action = "<CMD>lua require('trouble').next({skip_groups = true, jump = true})<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Trouble next";
      };
    }
    {
      key = "[d";
      mode = "n";
      action = "<CMD>lua require('trouble').previous({skip_groups = true, jump = true})<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Trouble prev";
      };
    }
    {
      key = "<leader>so";
      mode = "n";
      action = "<CMD>SymbolsOutline<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "SymbolsOutline";
      };
    }
    {
      key = "<leader>f";
      mode = ["n" "v"];
      action = "<CMD>lua require('conform').format()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Format";
      };
    }
  ];
}
