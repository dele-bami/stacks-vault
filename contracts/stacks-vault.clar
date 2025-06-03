;; STACKS VAULT - Advanced DeFi Staking & Governance Protocol
;;
;; Title: Stacks Vault Protocol
;;
;; Summary: A sophisticated Layer-2 Bitcoin-compliant DeFi protocol that enables 
;; users to stake STX tokens with tiered rewards, participate in decentralized 
;; governance, and earn yield through innovative tokenized positions.
;;
;; Description: Stacks Vault revolutionizes Bitcoin DeFi by providing a secure,
;; multi-tiered staking ecosystem where users can lock STX tokens to earn 
;; rewards based on their commitment level and tier status. The protocol 
;; features dynamic reward multipliers, governance participation through 
;; proposal creation and voting, emergency controls for security, and a 
;; sophisticated tier system that rewards long-term stakeholders with 
;; enhanced benefits and exclusive features.
;;
;; Key Features:
;; - Multi-tier staking with escalating rewards (1x, 1.5x, 2x multipliers)
;; - Time-locked staking for bonus rewards (up to 1.5x additional multiplier)
;; - Decentralized governance with proposal creation and voting
;; - Emergency pause functionality for protocol security
;; - Cooldown mechanisms to prevent flash loan attacks
;; - Native analytics token for enhanced protocol participation
;;

;; TOKEN DEFINITIONS

(define-fungible-token ANALYTICS-TOKEN u0)

;; CONSTANTS & ERROR CODES

(define-constant CONTRACT-OWNER tx-sender)

;; Error codes for enhanced debugging and user experience
(define-constant ERR-NOT-AUTHORIZED (err u1000))
(define-constant ERR-INVALID-PROTOCOL (err u1001))
(define-constant ERR-INVALID-AMOUNT (err u1002))
(define-constant ERR-INSUFFICIENT-STX (err u1003))
(define-constant ERR-COOLDOWN-ACTIVE (err u1004))
(define-constant ERR-NO-STAKE (err u1005))
(define-constant ERR-BELOW-MINIMUM (err u1006))
(define-constant ERR-PAUSED (err u1007))

;; DATA VARIABLES - PROTOCOL CONFIGURATION

(define-data-var contract-paused bool false)
(define-data-var emergency-mode bool false)
(define-data-var stx-pool uint u0)
(define-data-var base-reward-rate uint u500) ;; 5% base rate (100 = 1%)
(define-data-var bonus-rate uint u100) ;; 1% bonus for longer staking
(define-data-var minimum-stake uint u1000000) ;; Minimum stake amount (1M uSTX)
(define-data-var cooldown-period uint u1440) ;; 24 hour cooldown in blocks
(define-data-var proposal-count uint u0)

;; DATA MAPS - PROTOCOL STATE MANAGEMENT

;; Governance proposals with comprehensive voting mechanics
(define-map Proposals
    { proposal-id: uint }
    {
        creator: principal,
        description: (string-utf8 256),
        start-block: uint,
        end-block: uint,
        executed: bool,
        votes-for: uint,
        votes-against: uint,
        minimum-votes: uint,
    }
)

;; User positions with multi-dimensional tracking
(define-map UserPositions
    principal
    {
        total-collateral: uint,
        total-debt: uint,
        health-factor: uint,
        last-updated: uint,
        stx-staked: uint,
        analytics-tokens: uint,
        voting-power: uint,
        tier-level: uint,
        rewards-multiplier: uint,
    }
)

;; Individual staking positions with time-lock mechanics
(define-map StakingPositions
    principal
    {
        amount: uint,
        start-block: uint,
        last-claim: uint,
        lock-period: uint,
        cooldown-start: (optional uint),
        accumulated-rewards: uint,
    }
)