<h1 align="center">ChainCert: On-Chain Soulbound Certificates</h1>

ChainCert is a decentralized application (dApp) for issuing, storing, and verifying non-transferable (soulbound) certificates on the blockchain. Built with Solidity, Foundry, and a modern JavaScript frontend, it enables organizations to mint certificates directly to recipients' wallets, ensuring authenticity and permanence.

---

## Features

- **Soulbound ERC721 Certificates:** Certificates are minted as NFTs but cannot be transferred, ensuring they remain bound to the recipient's wallet.
- **On-Chain Metadata:** Each certificate stores name, course, date, and an image URI (IPFS) on-chain.
- **Easy Verification:** Anyone can verify a certificate by wallet address or certificate ID.
- **Modern Frontend:** Simple UI for minting and searching certificates, with wallet connect and IPFS image upload.

---

## Smart Contract

- **Location:** [`src/CertificateOnChain.sol`](src/CertificateOnChain.sol)
- **Key Functions:**
	- `mint(address recipient, string name, string date, string course, string imageURI)` — Only owner can mint new certificates.
	- `getCertificateById(uint256 id)` — Fetch certificate metadata by ID.
	- `getCertificatesByAddress(address wallet)` — Fetch all certificates owned by a wallet.
	- **Transfers are disabled**: Certificates cannot be transferred after minting.

---

## Frontend

- **Location:** [`frontend/index.html`](frontend/index.html)
- **Features:**
	- Connect wallet (MetaMask)
	- Mint certificate (owner only)
	- Upload certificate image to IPFS (via Pinata)
	- Search/verify by wallet address or certificate ID
	- Responsive, modern UI

---

## Getting Started

### Prerequisites
- [Foundry](https://book.getfoundry.sh/)
- Node.js (for frontend development, if you wish to extend)
- MetaMask (for interacting with the dApp)

### 1. Install Dependencies
```sh
forge install
```

### 2. Build & Test Contracts
```sh
forge build
forge test
```

### 3. Run Local Blockchain
```sh
anvil
```

### 4. Deploy Contract
Update the deploy script if needed, then run:
```sh
forge script script/DeployCertificateOnChain.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

### 5. Configure Frontend
- Update `CONTRACT_ADDRESS` in [`frontend/index.html`](frontend/index.html) to your deployed contract address.
- Optionally, update Pinata API keys for IPFS uploads.

### 6. Open Frontend
Just open `frontend/index.html` in your browser.

---

## Contract Overview

```solidity
struct metaData {
		string name;
		string date;
		string course;
		string imageURI;
}
```

- **mint**: Only the contract owner can mint certificates. Transfers are blocked after minting.
- **Soulbound**: `_update` is overridden to revert on any transfer attempt.

---

## Example Usage

### Minting a Certificate (Owner Only)
1. Connect wallet as contract owner.
2. Fill in recipient address, name, date, course, and upload an image.
3. Click "Mint Certificate" and confirm in MetaMask.

### Verifying a Certificate
1. Go to "Verify & Search" tab.
2. Enter a wallet address or certificate ID.
3. View all certificates owned or details for a specific certificate.

---

## Security & Notes
- Certificates are non-transferable (soulbound).
- Only the contract owner can mint.
- Images are stored on IPFS via Pinata.
- No backend server required.

---

## License

MIT
