from getpass import getpass
from mysql.connector import connect, Error

def stock(store: int, shipment:int, shipment_items: dict):
    # must unload shipment and move items into the store.
    # note the shipment has arrived and when it had arrived.
    # count the number of items, in case of vendor error or damaged items.
    # inventory will need to be updated with new stock  
    try:
        with connect(
            host="127.0.0.1",
            user = input("Enter username: "),
            password = getpass("Enter password: ") #BrianLaw67,
        ) as Connection:
            # looks at this in the future, may need to change to shipment table
            shipment_arrived_query = f"UPDATE Items_In_Shipment SET Items_recieved = 'Arrived' WHERE Shipment_ID = {shipment}"

            expected_shipment_amount = f"SELECT SUM(Quantity) FROM Items_Recieved"


            shipment_item_count = 0
            for count in shipment_items.values():
                shipment_item_count += count

            # Check with Professor on what the functionality should be when the order isn't fulfilled correctly.
            if shipment_item_count != expected_shipment_amount:
                print(f"Order expected {expected_shipment_amount}, Recieved {shipment_item_count} error has accured")

            # check if I need to add functionality where people can add new items into the inv
            for item in shipment_items:
                update_inv = f"UPDATE "

            


    except Error as e:
        print(e)





def main():
    pass

if __name__ == "__main__":
    main()