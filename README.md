# DFS and BFS in MIPS Assembly

## Overview

This project implements Depth-First Search (DFS) and Breadth-First Search (BFS) algorithms using MIPS assembly language. The code converts a BFS representation of a binary tree into a DFS representation and performs several operations including printing the DFS output and computing the logarithm base 2 of a given number.

## Project Structure

The project includes a single MIPS assembly file that contains:

1. **Data Section**:
   - `bfs`: Array representing the BFS traversal of a binary tree.
   - `length`: Length of the BFS array.
   - `dfs`: Array to store the DFS output.
   - `dfs_index`: Index to keep track of the current position in the DFS array.
   - `message`: String to print after completing the operations.

2. **Text Section**:
   - `main`: Entry point of the program. Loads BFS data, initializes DFS conversion, and prints the results.
   - `dfs_convert`: Recursive function to convert BFS representation to DFS.
   - `bfs_convert`: Recursive function to convert DFS representation to BFS.
   - `first_search`: Function to find the index of a target value in the BFS array.
   - `log_base_2`: Function to calculate the logarithm base 2 of a number.
   - `second_search`: Function to perform a search operation and use the previously implemented functions.

## Running the Code

1. **Assemble the Code**:
   Use a MIPS assembler such as `SPIM` or `MARS` to assemble the MIPS assembly code.

2. **Run the Code**:
   Execute the assembled code in a MIPS simulator. The output will display the DFS representation of the binary tree and print a message upon completion.

## Code Explanation

### Data Section
- `bfs`: Contains the BFS traversal of the binary tree.
- `length`: The number of elements in the BFS array.
- `dfs`: Used to store the DFS traversal.
- `dfs_index`: Keeps track of the current index in the DFS array.
- `message`: A string message to print upon completion.

### Main Procedure
- Initializes parameters and calls `dfs_convert` to convert BFS to DFS.
- Prints the DFS array.
- Displays a message after completing the operations.

### DFS Conversion
- `dfs_convert`: Recursively converts the BFS representation to DFS by traversing the binary tree.

### BFS Conversion
- `bfs_convert`: Converts DFS representation back to BFS format.

### Search Functions
- `first_search`: Searches for a target value in the BFS array and computes its logarithm base 2.
- `log_base_2`: Calculates the logarithm base 2 of a number.
- `second_search`: Demonstrates usage of the `bfs_convert` and `first_search` functions.
