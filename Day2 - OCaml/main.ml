open Printf

let read_file filename = 
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s



let solve_file (file_path: string) = 
  let lines = file_path
    |> read_file
    |> String.split_on_char '\n'
    |> List.map (String.split_on_char ':') 
    |> List.map Array.of_list
    |> Array.of_list
  in
  printf "Input file: %s\n" file_path;
  Array.iter (Array.iter (printf "%s\n"))lines
  (*printf "Part 1: %d\n" part_1 file_path;*)
  

let () = 
  Sys.argv
  |> Array.to_list
  |> List.tl
  |> List.iter solve_file