# Access Control System - Client Side
![few features demostration](./project%20images/features-client-sideV2.gif)
We can observe how the changes that the client makes from the mobile application are reflected in the server, being able to close propped doors, closing/locking doors and vice versa

## Overview
This milestone focuses on developing the user interface for the mobile application of our Access Control System (ACS). The app allows users to remotely manage access to rooms and areas within a building, providing functionalities such as locking, unlocking, opening, and closing doors interacting with the "access_control_system_server_side".

## Features
- **Navigation**: Users can navigate through the hierarchy of partitions, spaces, and doors within the building.
- **Door States**: The app displays the current state of doors, indicating whether they are open or closed, and their access state (locked/unlocked).
- **Remote Access Management**: User can send requests to the Access Control Unit (ACU) to lock or unlock individual doors.
- **Localization (l10n)**: The flutter aplication has been traduced to 3 different langaugaes. To use it, change on main.dart the attribut "locle :" where can be select different languages like english(en), spanish(es), catalan(ca).

## Installation
1. Clone the repository to your local machine.
2. Open the project with your flutter IDE
3. Run the file lib/main.dart
4. Make sure the "access_control_system_server_side" is already running https://github.com/lucas12avl/access_control_system_server_side

## Usage
Upon launching the app,the user can:
- Browse through the building's layout to locate specific doors or areas.
- View the status of each door and perform actions such as lock or unlock.
- Manage access rights for different user groups based on their roles and schedules.

## Author
lucas12avl
