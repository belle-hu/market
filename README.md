# Market
OCaml command-line app and database that supports CRUD operations.

# Project Description
Aim: We are simulating a grocery database that allows you to track items, 
prices, quantities, expenditures, and stock of a grocery store. We want to 
essentially track grocery store transactions and allow for customer interaction 
with the store. We divided our functionality into 4 modules: Items, Bagofgoods,
Expenditures, Store.

# Installation Details
Packages needed:
OCaml and OPAM

Installation steps:
1. Clone our git repository: 
git clone https://github.com/belle-hu/market.git
2. Enter directory of project
cd [project name]
3. install opam
4. dune build 

# Navigation Demo
## Step 1

Step 1. After dune build, run command to start interacting with a store. The 
default interface is in the perspective of the owner: 
### Command: make grocery
### Output

Welcome to your new grocery store! 

What would you like to name your store?

## Step 2

Step 2. Enter a name in the command line for your store (i.e. Sweet Shop)

Welcome to your new grocery store! 

What would you like to name your store?
### Input: Sweet Shop

### Output

Welcome to Sweet Shop!

Please provide a brief description of your store.

## Step 3
Step 3. Enter a description in the command line for your store (i.e. Selling Sweets!)  

Welcome to your new grocery store! 

What would you like to name your store?

### Input: Selling Sweets

### Output
Congrats on opening your new store, Sweet Shop: Selling Sweets! 

****************************************************************
Your store can do several things!
1. Create new item 
2. Change item price 
3. Import certain quantity of an item 
4. Show all items with their categories in store 
5. Show all item names in the store 
6. Show total quantity of all items in the store 
7. Show total value of all items in the store  
8. Discard certain quantity of an item 
9. Take a look at our items that have almost run out! 
10. Switch to customer mode 
11. Show transaction history 
Q. Quit

Please enter your choice of 1-11, or Q

### Step 4
Step 4. Enter a choice from 1 to 11 to interact with your store:

Here are some examples:

### Input: 1

### Output: 
Please enter the name, price, quantity, category of the item you want to create in the format of "[name] [price] [quantity] [category]" (eg. "apple 1 2 fruit")
Also, please note that you should not be creating a new item with the same name as an item you have already created. For example, if you previously created "apple 1 2 fruit", please do not create a new "apple 5 7 fruit". Instead, you should use the change_price or change_quantity functionalities. 
     (Price and quantity should be integers):
### Input: gummies 2 10292 candy
### Output

Successfully created item: gummies with price: 2 and quantity: 10292 in candy
The store now contains: Category: candy|({name = gummies; price = 2; quantity = 10292}, freq: 0); ||
****************************************************************
Your store can do several things!
1. Create new item 
2. Change item price 
3. Import certain quantity of an item 
4. Show all items with their categories in store 
5. Show all item names in the store 
6. Show total quantity of all items in the store 
7. Show total value of all items in the store  
8. Discard certain quantity of an item 
9. Take a look at our items that have almost run out!
10. Switch to customer mode 
11. Show transaction history 
Q. Quit

Please enter your choice of 1-11, or Q

### Input: 8

### Output

Please enter the name, the quantity, and the category of the item you want to remove in the format of "[name] [quantity_removed] [category] " (eg. "apple 1 fruit"). 
 The new quantity of the item will be original quantity - quantity_removed. 
 (Requirements: 1. quantity_removed should be an positive integer. 
 2. The name of the item you enter should already be created.)

 ### Input: gummies 20 candy
 ### Output
Successfully discard item: gummies of 20 amount in candy
****************************************************************
Your store can do several things!
1. Create new item 
2. Change item price 
3. Import certain quantity of an item 
4. Show all items with their categories in store 
5. Show all item names in the store 
6. Show total quantity of all items in the store 
7. Show total value of all items in the store  
8. Discard certain quantity of an item 
9. Take a look at our items that have almost run out! 
10. Switch to customer mode 
11. Show transaction history 
Q. Quit

Please enter your choice of 1-11, or Q

### Input: 4

### Output
Please enter the name, the quantity, and the category of the item you want to import in the format of "[name] [imported_quantity] [category]" (eg. "apple 2 fruit"). 
 The new quantity of the item will be original quantity + imported_quantity. 
 (Requirements: 1. imported_quantity should be an positive integer. 
 2. The name of the item you enter should already be created.)

 ### Input: gummies 2 candy
 ### Output
Successfully changed item: gummies with quantity_change: 2 in candy
****************************************************************
Your store can do several things!
1. Create new item 
2. Change item price 
3. Import certain quantity of an item 
4. Show all items with their categories in store 
5. Show all item names in the store 
6. Show total quantity of all items in the store 
7. Show total value of all items in the store  
8. Discard certain quantity of an item 
9. Take a look at our items that have almost run out! 
10. Switch to customer mode 
11. Show transaction history 
Q. Quit

Please enter your choice of 1-11, or Q

## Customer mode example

### Input: 10
### Output
Welcome to customer mode!
Dear customer, here are the items currently in the store:
Category: candy|({name = gummies; price = 2; quantity = 10274}, freq: 0); ||
****************************************************************
Do you want to buy some items? 
Please enter your choice of 1 or 2: 
1. Yes, I want to buy something.
2. I want to checkout. (Switch back to the store owner mode)
### Input: 1
### Output
Please enter the name, the quantity, and the category of the item you want to buy in the format of "[name] [quantity] [category]" (eg. "apple 1 fruit"):
Notice: 
     1. The name of the item you enter must be already in the store

### Input: gummies 20 candy
### Output

Successfully purchased item: gummies with quantity: 20 in candy
****************************************************************
Welcome to customer mode!
Dear customer, here are the items currently in the store:
Category: candy|({name = gummies; price = 2; quantity = 10254}, freq: 20); ||
****************************************************************
Do you want to buy some items? 
Please enter your choice of 1 or 2: 
1. Yes, I want to buy something.
2. I want to checkout. (Switch back to the store owner mode)

### Input: 2
### Output
Thank you for shopping at Sweet Shop
Here is your reciept: 
Product: gummies, Amount: 20, Price: 2
Done.
Your total is: 40  
We will switch back to store mode.
****************************************************************
Your store can do several things!
1. Create new item 
2. Change item price 
3. Import certain quantity of an item 
4. Show all items with their categories in store 
5. Show all item names in the store 
6. Show total quantity of all items in the store 
7. Show total value of all items in the store  
8. Discard certain quantity of an item 
9. Take a look at our items that have almost run out!
10. Switch to customer mode 
11. Show transaction history 
Q. Quit

Please enter your choice of 1-11, or Q
# How to quit
## Command: Q
### Output
Thank you for using our grocery system, Sweet Shop! Bye!

# Collaborators
Bellerina Hu (bh552@cornell.edu)  
Aileen Huang (aeh245@cornell.edu)  
Yuhan Sun (ys728@cornell.edu)  
Alina Yuan (ay332@cornell.edu)  