{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        line-number = "relative";
        trim-trailing-whitespace = true;
        jump-label-alphabet = "ueihdtoansp.gckjmwrlq";

        cursor-shape = {
          normal = "bar";
          insert = "block";
          select = "underline";
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
      };
      keys = {
        normal = {
          d = "move_char_left";
          h = "move_visual_line_down";
          t = "move_visual_line_up";
          n = "move_char_right";
          l = "find_till_char";
          L = "till_prev_char";
          k = "delete_selection";
          "A-k" = "delete_selection_noyank";
          ";" = "keep_selections";
          "A-;" = "remove_selections";
          g.d = "goto_line_start";
          g.n = "goto_line_end";
          g.l = "goto_window_top";
          g.h = "move_line_down";
          g.t = "move_line_up";
          g.j = "goto_definition";
          g.k = "goto_next_buffer";
          z.h = "scroll_down";
          z.t = "scroll_up";
          z.l = "align_view_top";
          m.k = "surround_delete";
          w.d = "jump_view_left";
          w.h = "jump_view_down";
          w.t = "jump_view_up";
          w.n = "jump_view_right";
          w.D = "swap_view_left";
          w.H = "swap_view_down";
          w.T = "swap_view_up";
          w.N = "swap_view_right";
        };
        insert = {
          "C-t" = "kill_to_line_end";
          "C-h" = "insert_newline";
        };
      };
    };
  };

  stylix.targets.helix.enable = true;
}
