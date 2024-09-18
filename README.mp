# ASCON128 Encryption Project

## Project Overview

This project involves the design and implementation of the ASCON128 authenticated encryption algorithm using **SystemVerilog**. ASCON128 is a lightweight cryptographic algorithm designed for authenticated encryption with associated data (AEAD), ensuring both confidentiality and authenticity of communications.

## Features

- **Authenticated Encryption**: Ensures both confidentiality and authenticity of messages.
- **ASCON128 Algorithm**: A lightweight encryption algorithm that uses a sponge function for authenticated encryption.
- **SystemVerilog Modeling**: Implement the ASCON128 algorithm in hardware using SystemVerilog.

## Algorithm Description

### ASCON128 Basics
ASCON128 uses a **sponge construction** and works with a 320-bit state, divided into:
- **64-bit external part** (`Sr`).
- **256-bit internal part** (`Sc`).

### Key Elements:
- **Key (K)**: 128-bit secret key.
- **Nonce (N)**: 128-bit arbitrary number.
- **Tag (T)**: 128-bit authentication tag.
- **Plaintext (P)**: 184-bit message to be encrypted.
- **Associated Data (A)**: 48-bit additional data (kept in plaintext).
- **Initialization Vector (IV)**: A fixed 64-bit value `0x80400C0600000000`.

### Encryption Process
The encryption process consists of four main phases:
1. **Initialization**: Initialize the 320-bit state `S` with `IV`, `K`, and `N`, followed by a 12-round permutation (`p12`).
2. **Associated Data Processing**: Inject associated data into the state with padding and apply 6-round permutations (`p6`).
3. **Plaintext Processing**: Encrypt the plaintext in blocks, with each block undergoing a 6-round permutation (`p6`).
4. **Finalization**: Generate a tag to authenticate the message using a 12-round permutation (`p12`).

### Permutations (p6 and p12)
The main transformations in ASCON128 are the permutations `p6` (6 rounds) and `p12` (12 rounds). These involve:
- **Constant Addition (pC)**: Add round constants to part of the state.
- **Substitution Layer (pS)**: A 5-bit S-box substitution applied in parallel to state columns.
- **Linear Diffusion Layer (pL)**: Apply a diffusion operation across the state rows.

## SystemVerilog Implementation

### Module Structure

The top-level module `ascon_top` contains:
- **Clock and Reset**:
  - `clock_i`: Input clock signal.
  - `resetb_i`: Active-low reset signal.
- **Input Ports**:
  - `data_i`: 64-bit input data.
  - `data_valid_i`: Signal indicating valid input data.
  - `key_i`: 128-bit encryption key.
  - `nonce_i`: 128-bit nonce.
  - `start_i`: Signal to start the encryption process.
- **Output Ports**:
  - `cipher_o`: 64-bit encrypted output data.
  - `cipher_valid_o`: Signal indicating valid cipher output.
  - `tag_o`: 128-bit authentication tag.
  - `end_o`: Signal indicating the end of the encryption process.

### Submodules
- **Permutation_xor**: Implements the core operations for the ASCON permutation (constant addition, substitution, and linear diffusion).
- **FSM (Finite State Machine)**: Controls the encryption flow, managing the input and output data, permutations, and counters.
