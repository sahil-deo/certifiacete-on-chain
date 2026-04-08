// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CertificateOnChain is ERC721, Ownable{

    error TransferNotAllowed();

    uint256 private _nextTokenId;

    struct metaData{
        string name;
        string date;
        string certificate_id;
        string imageURI;
    }

    mapping(uint256 => metaData) private _metaData;
    mapping(address => uint256[]) private _tokenOwners;

    constructor() ERC721("Certificate", "CERT") Ownable(msg.sender){}

    // overriding the _update function to prevent transfers
    function _update(address to, uint256 tokenId, address auth) internal override returns(address){
        address from = _ownerOf(tokenId);
        if (from != address(0)) revert TransferNotAllowed();
        return super._update(to, tokenId, auth);
    }

    function mint(address recepient, string memory name, string memory date, string memory id, string memory image) external onlyOwner returns (uint256) {
        
        metaData memory meta = metaData(name, date, id, image);
        uint256 tokenId = _nextTokenId++;
        _mint(recepient, tokenId);
        _metaData[tokenId] = meta;
        _tokenOwners[recepient].push(tokenId);    
        return tokenId;
    }

    function getCertificates() external view returns (metaData[] memory){
        
        uint256[] memory tokenIds = _tokenOwners[msg.sender];
        metaData[] memory result = new metaData[](tokenIds.length);
        for(uint256 i = 0;i<_nextTokenId;i++){
            if(_ownerOf(i)==msg.sender){
                result[i]= _metaData[tokenIds[i]];
            }
        }
        return result;
    }
}