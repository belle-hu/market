  open Bagofgoods
  open Items
  module type StoreType = sig 
    type 'a t 
    val count_products: 'a t -> int 
    val all_products: 'a t -> 'a t  
    val sell_goods: int -> (Item.t) -> 'a t -> 'a t 
    val popular_goods: int -> 'a t -> 'a t
    val in_stock_goods: 'a t -> 'a t
    val of_list: BagOfGoods.t list -> 'a t 
    val to_list: 'a t -> BagOfGoods.t list
    val map: (BagOfGoods.t -> BagOfGoods.t) -> BagOfGoods.t list -> BagOfGoods.t list 
    val filter: (BagOfGoods.t -> bool) -> BagOfGoods.t list -> BagOfGoods.t list 
  end 

  module Store : StoreType = struct

  type 'a t = BagOfGoods.t list 

  (**Allows user to see list of all StoreProducts in given Store [st]. Returns a
  list of StoreProducts*) 
  let all_products st: BagOfGoods.t list = st

  let empty = []
  
  (*[count_bag bg] counts the number of items in [bg]*)
  let rec count_bag bg = 
    match BagOfGoods.to_list bg with 
    | []-> 0 
    | h::t -> Item.get_quantity h + count_bag (BagOfGoods.of_list t)

  (**Count the number of products in a given store [st].*) 
  let rec count_products st = 
    match st with 
    | [] -> 0 
    | h :: t -> count_bag h + count_products t

  (**Given a list of BagOfGoods [b_lst] and a store [st], add all
  goods of [bg] to the store [st].*) 
  let import_goods bg st = 
    (*Check for uniqueness of items?*) 
    BagOfGoods.to_list bg :: st

  (**Keep a list that tracks out_of_stock_goods each time we sell a good*) 
  let out_of_stock_goods = ref []

    (*Get bag of deleted items from a bag*)
  let rec get_del_items bg = 
    match (BagOfGoods.to_list bg) with 
    | [] -> out_of_stock_goods := List.append !out_of_stock_goods []
    | h::t -> 
      if Item.get_quantity h <= 0 then  
      out_of_stock_goods :=  (List.append !out_of_stock_goods [h])
     else 
    get_del_items (BagOfGoods.of_list t)
  (*[del_items bg] deletes items of a bag [bg] if their quantity is less than
     or equal to zero.*)
  let rec del_items bg = 
    get_del_items bg;
    match (BagOfGoods.to_list bg) with 
    | [] -> BagOfGoods.empty
    | h::t -> if Item.get_quantity h <= 0 then  
      del_items (BagOfGoods.of_list t) else 
    BagOfGoods.join (BagOfGoods.of_list [h]) (del_items (BagOfGoods.of_list t))
      
  (*[store_change_quan dec item bg] sells [dec] amount of [item] in [bg]
     and returns a new bag with the updated amount of [item] *)
  let rec store_change_quan dec (item:Item.t) bg = 
    match BagOfGoods.to_list bg with 
    | [] -> BagOfGoods.empty
    | h :: t-> 
    if (Item.get_name item == Item.get_name h) then 
    let new_item = Item.change_quantity h (-1 * dec)
    in (BagOfGoods.of_list (new_item::t) )
    else 
      BagOfGoods.join (BagOfGoods.of_list [h]) (store_change_quan dec item (BagOfGoods.of_list t))
          
  (**Sell [dec] amount of an item [item] within a given store
  [st]. Requires that [b] is a good in [st] already.*)
  let rec sell_goods dec (item:Item.t) st = 
  match st with 
  | [] -> []
  | h :: t-> 
    let b1 = (store_change_quan dec item h) in 
    let b2 = del_items b1 in b2:: (sell_goods dec item t) 

  let rec delete_bag (bg: BagOfGoods.t) st = 
    match st with 
    | [] -> []
    | h::t -> if h == bg then t else delete_bag bg t

  (*[clean st] cleans the store of empty bags*)
  let rec clean st = 
    match st with 
    | [] -> empty
    | h::t -> if h == BagOfGoods.empty then clean t 
    else h :: clean t

  let rec determine_popular bag_goods lim = 
    match BagOfGoods.to_list bag_goods with 
    | [] -> BagOfGoods.empty
    | h :: t
  -> if Item.get_quantity h <= lim then 
    BagOfGoods.join (BagOfGoods.of_list [h]) (determine_popular (BagOfGoods.of_list t) lim)
      else determine_popular (BagOfGoods.of_list t) lim

  (*[popular_goods] returns all the bags of goods in [st] with only popular items in them, 
     determined by whether the quantity of an item is less than or equal to the [lim]*)
  let rec popular_goods lim st = 
    match st with | [] -> [] | h :: t ->
  (determine_popular h lim :: popular_goods lim t) |> clean 

  (*talk about this: how to determine if good is on sale: add a on_sale field to
  BagOfGoods?*)
  let in_stock_goods st = st 

  (*Given a list of bag of goods list, convert to a store*)
  let rec of_list (bg_list:BagOfGoods.t list) = bg_list
  
  let to_list (bg_list:BagOfGoods.t list) = bg_list

  let rec map (f: BagOfGoods.t -> BagOfGoods.t) st = 
    match st with 
    | [] -> []
    | h::t -> f h :: map f t
  
  let rec filter(f: BagOfGoods.t -> bool) st = 
    List.filter f st
end 