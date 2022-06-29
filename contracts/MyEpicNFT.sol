//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// We need some util functions for strings.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
contract MyEpicNFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["Happy", "Dangerous", "Sad", "Crazy", "Funny", "Wild", "Terryfying", "Frightened", "Bored", "Amazed"];
    string[] secondWords = ["White", "Black", "Green", "Red", "Purple", "Yellow", "Orange", "Blue", "Pink", "Gold"];
    string[] thirdWords = ["Panda", "Mouse", "Goose", "Owl", "Butterfly", "Mosquito", "Spider", "Frog", "Snake", "Sheep"];

    
    constructor () ERC721 ("SquareNFT", "SQUARE") { 
        console.log("This is my NFT contract!!!");
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory){
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory){
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory){
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }


    function makeAnEpicNFT() public {
        // tokenIds для отслеживания уникального идентификатора NFT (defaulft: 0)
        uint256 newItemId = _tokenIds.current();

        string memory firstWord = pickRandomFirstWord(newItemId);
        string memory secondWord = pickRandomSecondWord(newItemId);
        string memory thirdWord = pickRandomThirdWord(newItemId);

        string memory finalSvg = string(abi.encodePacked(baseSvg, firstWord, secondWord, thirdWord, "</text></svg>"));
        console.log("<----------------------------------\n", finalSvg, "\n--------------------------------->");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, "blah");

        _tokenIds.increment();

        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}