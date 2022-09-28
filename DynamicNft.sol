//Begin
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

contract randomnum is ERC721, ERC721URIStorage, KeeperCompatibleInterface {
    using Counters for Counters.Counter;

    Counters.Counter public tokenIdCounter;
 
   
    string[] IpfsUri = [
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/1.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/2.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/3.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/4.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/5.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/6.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/7.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/8.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/9.json",
        "https://gateway.pinata.cloud/ipfs/QmeLPYui885AhGEkWHpStYLc7NxiCRWwpHVxvdqqApy6qy/10.json"
        
    ]; 

    uint256 lastTimeStamp;
    uint256 interval;

    constructor(uint _interval) ERC721("randomnum", "RNM") {
        interval = _interval;
        lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory /* performData */) {
        uint256 tokenId = tokenIdCounter.current() - 1;
        bool done;
        if (genstate(tokenId) >= 4) {
            done = true;
        }
        upkeepNeeded = !done && ((block.timestamp - lastTimeStamp) > interval);        
        // We don't use the checkData in this example. The checkData is defined when the Upkeep was registered.
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        //We highly recommend revalidating the upkeep in the performUpkeep function
        if ((block.timestamp - lastTimeStamp) > interval ) {
            lastTimeStamp = block.timestamp;
            uint256 tokenId = tokenIdCounter.current() - 1;
            generate(tokenId);
        }
        // We don't use the performData in this example. The performData is generated by the Keeper's call to your checkUpkeep function
    }

    function safeMint(address to) public {
        uint256 tokenId = tokenIdCounter.current();
        tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, IpfsUri[0]);
    }

    function generate(uint256 _tokenId) public {
        
        if(genstate(_tokenId) >= 4){
            
            string memory newUri = IpfsUri[0];
            // Update the URI
            _setTokenURI(_tokenId, newUri);
            return;
        } else {
            
            uint256 newVal = genstate(_tokenId) + 1;
            // store the new URI
            string memory newUri = IpfsUri[newVal];
            // Update the URI
            _setTokenURI(_tokenId, newUri);
        }
    }

    // determine the stage of the car models
    function genstate(uint256 _tokenId) public view returns (uint256) {
        string memory _uri = tokenURI(_tokenId);
        
        if (compareStrings(_uri, IpfsUri[0])) {
            return 0;
        }
        
        if (
            compareStrings(_uri, IpfsUri[1]) 
        ) {
            return 1;
        }
       
        if (
            compareStrings(_uri, IpfsUri[2]) 
        ) {
            return 2;
        }
        
        if (
            compareStrings(_uri, IpfsUri[3]) 
        ) {
            return 3;
        }
        if (
            compareStrings(_uri, IpfsUri[4]) 
        ) {
            return 4;
        }
        if (
            compareStrings(_uri, IpfsUri[5]) 
        ) {
            return 5;
        }
        if (
            compareStrings(_uri, IpfsUri[6]) 
        ) {
            return 6;
        }
        if (
            compareStrings(_uri, IpfsUri[7]) 
        ) {
            return 7;
        }
        if (
            compareStrings(_uri, IpfsUri[8]) 
        ) {
            return 8;
        }
        if (
            compareStrings(_uri, IpfsUri[9]) 
        ) {
            return 9;
        }
        
        return 10;
    }

    
    function compareStrings(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    
    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
