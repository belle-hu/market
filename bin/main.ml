open Grocery
open Store
open Items
open Bagofgoods
open Expenditure

(**Store history*)
let bag = ref FrequencyBagGoods.empty

(**Choice 2*)

(*Helper method: [update_bag bg item_name quan price] searches through a Bag of
  goods [bg] for an item with the same [item_name] and updates price and/or
  quantity accordingly. If the same item exists, we return an updated item with
  a quantity [quan] and new price [price + item's old price]. If the item
  doesn't already exist, we'll return a new item instead. *)
let rec search_bag bg item_name quan price_change =
  match FrequencyBagGoods.to_list bg with
  | [] -> Item.create item_name quan price_change
  | h :: t ->
      if Item.get_name h == item_name then
        let p_change = Item.change_price h price_change in
        Item.change_quantity p_change quan
      else search_bag (FrequencyBagGoods.of_list t) item_name quan price_change

let change_price () =
  print_endline
    "\n\
     Please enter the name and the price_change of the item you want to change \
     in the format of \"[name] [price_change]\" (eg. \"apple 2 3\"). \n\
    \ The new price of the item will be original price + price_change. \n\
    \ (Requirements: 1. new_price should be an integer. It can be negative. \n\
    \ 2. The name of the item you enter should already be created.)\n";
  match String.split_on_char ' ' (read_line ()) with
  | [ nam; price_change ] ->
      (bag :=
         FrequencyBagGoods.(update_price !bag nam (int_of_string price_change)));
      print_endline
        ("Successfully changed item: " ^ nam ^ " with price_change: "
       ^ price_change)
  | _ -> failwith "Invalid input"

let change_quantity () =
  print_endline
    "\n\
     Please enter the name and the quntity_change of the item you want to \
     change in the format of \"[name] [price_change]\" (eg. \"apple 2 3\"). \n\
    \ The new quantity of the item will be original quantity + quantity_change. \n\
    \ (Requirements: 1. new_quantity should be an integer. It can be negative. \n\
    \ 2. The name of the item you enter should already be created.)\n";
  match String.split_on_char ' ' (read_line ()) with
  | [ nam; quantity_change ] ->
      (bag :=
         FrequencyBagGoods.(
           update_quantity !bag nam (int_of_string quantity_change)));
      print_endline
        ("Successfully changed item: " ^ nam ^ " with quantity_change: "
       ^ quantity_change)
  | _ -> failwith "Invalid input"

(**Helper method: converts all the information in an item into a single string*)
let item_to_string (item : Item.t) : string =
  let name = Item.get_name item in
  let price = string_of_int (Item.get_price item) in
  let quantity = string_of_int (Item.get_quantity item) in
  name ^ " (Price: " ^ price ^ ", Quantity: " ^ quantity ^ ")"

(**Choice 1*)
let create_item_add_to_bag () =
  print_endline
    "\n\
     Please enter the name, price, and quantity of the item you want to create \
     in the format of \"[name] [price] [quantity]\" (eg. \"apple 1 2\")\n\
     Also, please note that you should not be creating a new item with the \
     same name as an item you have already created. For example, if you \
     previously created \"apple 1 2\", please do not create a new \"apple 5 \
     7\". Instead, you should use the change_price or change_quantity \
     functionalities. \n\
    \     (Price and quantity should be integers):";
  match String.split_on_char ' ' (read_line ()) with
  | [ nam; pri; quan ] ->
      let item1 = Item.create nam (int_of_string pri) (int_of_string quan) in
      print_endline
        ("Successfully created item: " ^ Item.get_name item1 ^ " with price: "
        ^ string_of_int (Item.get_price item1)
        ^ " and quantity: "
        ^ string_of_int (Item.get_quantity item1));
      (bag := FrequencyBagGoods.(join !bag (of_list [ item1 ])));
      print_endline
        ("Bag now contains: "
        ^ String.concat ","
            (List.map Item.to_string (FrequencyBagGoods.to_list !bag)))
  | _ -> failwith "Invalid input"

(*Choice 5*)
let show_item_names () =
  let item_names = FrequencyBagGoods.names !bag in
  print_endline "The list of items are:";
  List.iter (fun name -> print_endline ("- " ^ name)) item_names

(*Choice 6*)
let show_total_quantity () =
  let total_quant = FrequencyBagGoods.total_quantity !bag in
  print_endline
    ("The total quantity of all items in the store is: "
   ^ string_of_int total_quant)

(*Choice 7*)
let show_total_cost () =
  let total_cost = FrequencyBagGoods.total_cost !bag in
  print_endline
    ("The total cost of all items in the store is: $" ^ string_of_int total_cost)

(*Choice 8*)
let remove_item () =
  print_endline "Please enter the name of the item you want to remove:";
  let item_name = read_line () in
  try
    bag := FrequencyBagGoods.remove !bag item_name;
    print_endline ("Successfully removed item: " ^ item_name);
    print_endline
      ("Bag now contains: "
      ^ String.concat ","
          (List.map Item.to_string (FrequencyBagGoods.to_list !bag)))
  with Failure msg -> print_endline msg

(*Welcome message*)
let welcome_msg () =
  print_endline "\n\nWelcome to your new grocery store! \n";
  print_endline "What would you like to name your store?\n";
  let rec get_store_name () =
    let x = read_line () in
    if String.trim x = "" then (
      print_endline
        "You cannot leave your store name blank! Please enter a name:";
      get_store_name ())
    else x
  in
  let store_name = get_store_name () in
  let _ = print_endline ("\nWelcome to " ^ store_name ^ "!") in
  let _ =
    print_endline "\nPlease provide a brief description of your store.\n"
  in
  let y = read_line () in
  print_endline
    ("Congrats on opening your new store, " ^ store_name ^ ": " ^ y ^ "\n")

let dont_use () =
  print_endline "\n\nWelcome to your new grocery store! \n";
  print_endline "What would you like to name your store?\n";
  match read_line () with
  | x -> (
      print_endline ("Welcome to " ^ x ^ "!");
      print_endline "1. Create new item 2. Change item price";
      print_endline "\nPlease enter your choice of 1 or 2\n";
      match read_line () with
      | "1" -> create_item_add_to_bag ()
      | "2" -> change_price ()
      | _ -> failwith "Invalid input")

(**Main interface*)
let rec work () =
  print_endline
    "****************************************************************";
  print_endline
    "Your store can do several things!\n\
     1. Create new item \n\
     2. Change item price \n\
     3. Change item quantity\n\
     4. Show all items in the store \n\
     5. Show all item names in the store \n\
     6. Show total quantity of all items in the store \n\
     7. Show total cost of all items in the store  \n\
     8. Remove an item \n\
     Q. Quit";
  print_endline "\nPlease enter your choice of 1-8, or Q\n";
  match read_line () with
  | "1" ->
      create_item_add_to_bag ();
      work ()
  | "2" ->
      change_price ();
      work ()
  | "3" ->
      change_quantity ();
      work ()
  | "4" ->
      print_endline
        ("Bag now contains: "
        ^ String.concat ","
            (List.map Item.to_string (FrequencyBagGoods.to_list !bag)));
      work ()
  | "5" ->
      show_item_names ();
      work ()
  | "6" ->
      show_total_quantity ();
      work ()
  | "7" ->
      show_total_cost ();
      work ()
  | "8" ->
      remove_item ();
      work ()
  | "Q" ->
      print_endline "Thank you for using our grocery system! Bye!";
      ()
  | _ -> failwith "Invalid input"

let () =
  welcome_msg ();
  work ()
