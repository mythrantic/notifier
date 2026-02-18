from plyer import notification
from fastmcp import FastMCP

mcp = FastMCP(
    name="notifier-mcp",
)

@mcp.tool()
def notify_user(title: str, message: str) -> str:
    """Send a notification to the user

    Args:
        title (str): The title of the notification
        message (str): The message of the notification

    Returns:
        str: Confirmation message
    """
    notification.notify(
        title=title,
        message=message,
        timeout=5  # duration in seconds
    )
    return "Notification sent successfully"

if __name__ == "__main__":
    mcp.run(transport="http", host="0.0.0.0", port=8082)
