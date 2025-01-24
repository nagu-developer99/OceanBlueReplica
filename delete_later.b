import streamlit as st
from datetime import datetime

# Set page layout
st.set_page_config(page_title="ChatGPT Interface", layout="wide")

# Initialize session state
if "chats" not in st.session_state:
    st.session_state.chats = []

if "current_chat_index" not in st.session_state:
    st.session_state.current_chat_index = 0

if "user_input" not in st.session_state:
    st.session_state.user_input = ""

def add_message(role, content):
    timestamp = datetime.now().strftime("%H:%M:%S")
    st.session_state.chats[st.session_state.current_chat_index]["messages"].append({
        "role": role,
        "content": content,
        "time": timestamp
    })

def new_chat():
    if st.session_state.current_chat_index < len(st.session_state.chats) - 1:
        st.session_state.chats = st.session_state.chats[:st.session_state.current_chat_index + 1]
    
    st.session_state.chats.append({
        "id": len(st.session_state.chats) + 1,
        "messages": []
    })
    st.session_state.current_chat_index = len(st.session_state.chats) - 1

def send_message():
    if st.session_state.user_input:
        user_message = st.session_state.user_input
        add_message("user", user_message)
        bot_reply = f"You said: {user_message}"  # Simple echo for demonstration
        add_message("bot", bot_reply)
        st.session_state.user_input = ""  # Clear the input box

def load_chat(index):
    st.session_state.current_chat_index = index

# Sidebar for chat history
with st.sidebar:
    st.title("Chat History")
    for i, chat in enumerate(st.session_state.chats):
        if st.button(f"Chat {chat['id']}", key=f"chat_{i}"):
            load_chat(i)

    if st.button("New Chat", key="new_chat_button"):
        new_chat()

# Main chat interface
st.title("ChatGPT Interface")

# Chat display area
chat_area = st.container()

with chat_area:
    if st.session_state.chats:
        for message in st.session_state.chats[st.session_state.current_chat_index]["messages"]:
            role = "**You:**" if message["role"] == "user" else "**Bot:**"
            st.markdown(f"{role} {message['content']} (_{message['time']}_)\n")

# User input area
st.text_input("Type your message:", key="user_input", on_change=send_message)

# Send button
st.button("Send", on_click=send_message, key="send_button")

# Initialize the first chat if there are no chats
if not st.session_state.chats:
    new_chat()
