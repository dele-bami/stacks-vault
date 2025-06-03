# Stacks Vault Protocol

**Stacks Vault** is an advanced, Bitcoin-compliant DeFi protocol built on the Stacks blockchain. It introduces a secure and dynamic staking ecosystem where users can lock STX tokens in return for tiered rewards, governance rights, and participation in a sustainable token economy. Designed to enhance long-term commitment, Stacks Vault combines security, decentralization, and financial incentives to push the boundaries of Layer-2 Bitcoin DeFi.

---

## Summary

* **Protocol Type:** Layer-2 Bitcoin-compatible DeFi Staking & Governance
* **Token Used:** STX (native), ANALYTICS-TOKEN (internal utility/rewards)
* **Security Features:** Emergency pause, cooldowns, time-locks
* **Governance:** Decentralized, proposal-based voting system
* **Staking Model:** Tiered, time-locked, and multiplier-based

---

## Key Features

### 🔐 Multi-Tiered Staking

* Bronze (1x), Silver (1.5x), and Gold (2x) tiers based on STX commitment
* Tiers are dynamically assigned based on total stake
* Time-locked staking offers **additional multipliers**:

  * 1 month lock = 1.25x
  * 2 months lock = 1.5x

### 🗳️ Decentralized Governance

* Users with ≥1M voting power can create proposals
* On-chain voting using **weighted voting power**
* Voting window is configurable (between 100–2880 blocks)

### 🛡️ Security & Anti-Abuse

* Emergency **pause** capability by contract owner
* Cooldown mechanisms before unstaking to prevent flash-loan exploits
* Minimum staking threshold of **1M uSTX** to reduce spam

### 📈 Native Utility Token

* `ANALYTICS-TOKEN` used to track and incentivize deeper engagement
* Grant additional participation rights and metrics-based rewards

---

## Smart Contract Overview

| Component             | Description                                                               |
| --------------------- | ------------------------------------------------------------------------- |
| `UserPositions`       | Tracks each user's stake, tier, voting power, and rewards multiplier      |
| `StakingPositions`    | Records time-locked positions, cooldowns, and accrued rewards             |
| `Proposals`           | Decentralized governance mechanics with voting counters and block windows |
| `TierLevels`          | Defines staking thresholds and feature access by tier                     |
| `contract-paused`     | Emergency halt for contract activity                                      |
| `base-reward-rate`    | Global staking reward rate baseline                                       |
| `calculate-rewards()` | Internal logic to compute accrued rewards based on time and multipliers   |

---

## Suggested Protocol Architecture

While on-chain logic is fully self-contained in the smart contract, the complete deployment architecture for **Stacks Vault** may include the following components:

```
+----------------------+     +--------------------+     +----------------------+
|  Stacks Vault UI     | --> |  Clarity Smart     | --> |  Stacks Blockchain   |
|  (React/Web3 front)  |     |  Contract Layer     |     |  L1 + L2 STX logic   |
+----------------------+     +--------------------+     +----------------------+

         |
         v
+----------------------+
|  Analytics Service   |
| (Off-chain indexer)  |
| - Track voting power |
| - Governance stats   |
| - Reward history     |
+----------------------+
```

### 🔧 Development Stack

* **Smart Contracts**: Clarity (Stacks)
* **Frontend**: React.js + Hiro Wallet
* **Indexing** (optional): Stacks.js or custom GraphQL off-chain indexer

---

## 📦 Getting Started

### 🔨 Deploying the Contract

1. Install [Clarinet](https://docs.stacks.co/write-smart-contracts/clarinet/overview/)
2. Clone this repository
3. Initialize and test:

   ```bash
   clarinet check
   clarinet test
   ```

4. Deploy to Stacks testnet/mainnet with:

   ```bash
   clarinet deploy
   ```

---

## 📄 Public Functions

* `stake-stx(amount, lock-period)`
* `initiate-unstake(amount)`
* `complete-unstake()`
* `create-proposal(description, voting-period)`
* `vote-on-proposal(proposal-id, vote-for)`
* `pause-contract()` / `resume-contract()`

---

## 🧪 Testing & Simulation

All functions are testable in the Clarinet testing environment. Governance votes, tier upgrades, and staking multipliers can be simulated with block advancement.
