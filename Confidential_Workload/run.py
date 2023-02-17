import time

fake_value = [0,1]
fake_connection_string = "MY_FAKE_CONNECTION_STRING"
fake_user_id = "Bob Uncle"
fake_decryption_key = "xxx42xxx"

def change_my_array():
    global fake_value
    fake_value.append(fake_value[-1] + 1)
    mini_variable = "try to catch this."

if __name__ == "__main__":
    while(True):
        time.sleep(5)
        change_my_array()
        print(fake_value)
