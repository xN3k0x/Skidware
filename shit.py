drinks = ["Espresso","Cappucino","Latte"] #สร้างตัวแปล "drinks" เก็บค่าเป็นประเภท "array" (มันเก็บค่าหลายตัวในตัวแปลเดียวกันได้)

print("--Welcome to Atom's Coffee--\n")
show_menu_input = int(input("Please type 1 to show menu: ")) #รับค่าจากผู้ใช้แล้วนำไปเปลี่ยนเป็นตัวเลขแล้วเก็บไว้ในตัวแปร "show_menu_input"
if show_menu_input == 1: #เช็คว่าตัวแปร "show_menu_input" มีค่าเท่ากับ1
    print("--- Choose the menu ---")
    for drink in drinks: #ดึงค่าทั้งหมดในตัวแปร "drinks" แล้วเก็บไว้ในตัวแปร "drink"
        print(str(drinks.index(drink)+1)+".",drink) #หาว่าตัวแปร "drink" ตอนนี้อยู่ลำดับที่เท่าไหร่แล้ว +1 แล้วก็ print ออกมา (ที่ต้อง +1 เพราะลำดับมันจะเริ่มจาก 0 ถ้า +1 จะเริ่ม ที่ 1)
    select_coffee_input = int(input("Select Coffee: ")) 
    print("--- Choose the type of coffee ---")
    print("1.) Hot 55 baht")
    print("2.) Hot 60 baht")
    select_type_input = int(input("Select Type: "))
    
    if drinks[select_coffee_input-1]: #เช็คว่าเครื่องดื่มตามหมายเลขที่ได้รับมีอยู่หรือเปล่า
        coffee = drinks[select_coffee_input-1] #ยัดชื่อเครื่องดื่มลงตัวแปร "coffee"
    
    if select_type_input == 1: #เช็คว่าถ้าตัวแปร "select_type_input" มีค่าเท่ากับ 1 (Hot) หรือเปล่า
        coffee_type = "Hot" #ถ้าใช่ให้สร้างตัวแปร "coffee_type" และใส่ค่า "Hot"
        cost = 55 #ถ้าใช่ให้สร้างตัวแปร "cost" และใส่ค่า 55
    else: #ถ้าไม่ใช่
        coffee_type = "Cold" 
        cost = 60
        
    print("--- You Chose",coffee_type,coffee,cost,"Baht","---") #print ประเภทกาแฟ, กาแฟ, ราคา 
    money_input = int(input("Input Your Money: "))
    if money_input >= cost: #เช็คว่าถ้ามีเงินมากกว่าราคาหรือเปล่า
        print("You Receive A Change Of",money_input-cost,"Baht") #ถ้าใช่จะให้มันคำนวณเงินทอน
    else:
        print("อย่ามาตลก 🤡")
else:
    print("แล้วมาไม 🤡")
