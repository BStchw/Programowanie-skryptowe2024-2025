import json
from rasa_sdk import Action

MENU = [
    {"name": "Lasagne", "price": 16, "preparation_time": 1},
    {"name": "Pizza", "price": 12, "preparation_time": 0.5},
    {"name": "Hot-dog", "price": 4, "preparation_time": 0.1},
    {"name": "Burger", "price": 12.5, "preparation_time": 0.2},
    {"name": "Spaghetti Carbonara", "price": 15, "preparation_time": 0.5},
    {"name": "Tiramisu", "price": 11, "preparation_time": 0.15},
]

class ActionListMenu(Action):
    def name(self):
        return "action_list_menu"

    def run(self, dispatcher, tracker, domain):
        if not MENU:
            dispatcher.utter_message("The menu is currently unavailable.")
        else:
            menu_text = "\n".join([f"- {item['name']} ({item['price']} PLN)" for item in MENU])
            dispatcher.utter_message(f"Here is the menu:\n{menu_text}")
        return []

OPENING_HOURS = {
    "Monday": {"open": 8, "close": 20},
    "Tuesday": {"open": 8, "close": 20},
    "Wednesday": {"open": 10, "close": 16},
    "Thursday": {"open": 8, "close": 20},
    "Friday": {"open": 8, "close": 20},
    "Saturday": {"open": 10, "close": 23},
    "Sunday": {"open": 0, "close": 0}
}

class ActionCheckOpeningHours(Action):
    def name(self):
        return "action_check_opening_hours"

    def run(self, dispatcher, tracker, domain):
        user_day = tracker.get_slot("day")  # np. "Monday"
        if not user_day:
            dispatcher.utter_message("For which day do you want to check opening hours?")
            return []

        if user_day in OPENING_HOURS:
            day_info = OPENING_HOURS[user_day]
            if day_info["open"] == 0 and day_info["close"] == 0:
                dispatcher.utter_message(f"The restaurant is closed on {user_day}.")
            else:
                dispatcher.utter_message(f"The restaurant is open from {day_info['open']}:00 to {day_info['close']}:00 on {user_day}.")
        else:
            dispatcher.utter_message("I don't have information for that day.")

        return []

class ActionHandleUserInput(Action):
    def name(self):
        return "action_handle_user_input"

    def run(self, dispatcher, tracker, domain):
        user_message = tracker.latest_message.get("text").lower()

        if "menu" in user_message:
            dispatcher.utter_message("Here is the menu:\n- Lasagne (16 PLN)\n- Pizza (12 PLN)...")
        elif "hello" in user_message or "hi" in user_message:
            dispatcher.utter_message("Hello! How can I assist you today?")
        elif "who are you" in user_message:
            dispatcher.utter_message("Hi, I am your restaurant assistant. How can I help you today?")
        elif "order" in user_message:
            dispatcher.utter_message("Sure, I can take your order. What would you like to order?")
        else:
            dispatcher.utter_message("Sorry, I didn't quite understand that.")

        return []

class ActionPlaceOrder(Action):
    def name(self):
        return "action_place_order"

    def run(self, dispatcher, tracker, domain):
        menu_items = [item["name"].lower() for item in MENU]
        order = tracker.latest_message["text"].lower()
        items_ordered = [item for item in menu_items if item in order]

        if not items_ordered:
            dispatcher.utter_message("I haven't found your order, but I can try to send it to the kitchen!")
        else:
            dispatcher.utter_message(f"Order accepted: {', '.join(items_ordered)}")

        return []

class ActionIntroduceBot(Action):
    def name(self):
        return "action_introduce_bot"

    def run(self, dispatcher, tracker, domain):
        dispatcher.utter_message("Hello! I am a virtual assistant designed to help you with restaurant-related tasks. How can I assist you today?")

        return []
