let mean lst =
  let total = List.fold_left (+.) 0.0 lst in
  total /. float_of_int (List.length lst)

let median lst =
  let sorted = List.sort compare lst in
  let len = List.length sorted in
  if len mod 2 = 0 then
    (List.nth sorted (len/2 - 1) +. List.nth sorted (len/2)) /. 2.0
  else
    List.nth sorted (len/2)

let mode lst =
  let freq = List.fold_left (fun acc x ->
    let count = try List.assoc x acc + 1 with Not_found -> 1 in
    (x, count) :: List.remove_assoc x acc
  ) [] lst in
  let max_count = List.fold_left (fun acc (_, c) -> max acc c) 0 freq in
  List.filter (fun (_, c) -> c = max_count) freq
  |> List.map fst

let () =
  let data = [1.0; 2.0; 2.0; 3.0; 4.0] in
  Printf.printf "Mean: %.2f\n" (mean data);
  Printf.printf "Median: %.2f\n" (median data);
  Printf.printf "Mode: ";
  List.iter (Printf.printf "%.0f ") (mode data);
  print_newline ()

