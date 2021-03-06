pragma solidity ^0.4.23;

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/token/ERC721/ERC721.sol
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract StarNotary is ERC721 {

    struct Star {
        string name;
        //string symbol;
    }

    //  Add a name and a symbol for your starNotary tokens
    string public constant name = "Caesar Star";
    string public constant symbol = "KING";

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    function createStar(string _name, uint256 _tokenId) public {
        //Star memory newStar = Star(_name, _symbol);
        Star memory newStar = Star(_name);

        tokenIdToStarInfo[_tokenId] = newStar;

        _mint(msg.sender, _tokenId);
    }

    // Add a function lookUptokenIdToStarInfo,
    // that looks up the stars using the Token ID,
    // and then returns the name of the star.
    function lookUptokenIdToStarInfo(uint256 _tokenId) view public returns (string result) {
        result = tokenIdToStarInfo[_tokenId].name;
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender);

        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0);

        uint256 starCost = starsForSale[_tokenId];
        address starOwner = ownerOf(_tokenId);
        require(msg.value >= starCost);

        _removeTokenFrom(starOwner, _tokenId);
        _addTokenTo(msg.sender, _tokenId);

        starOwner.transfer(starCost);

        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
        starsForSale[_tokenId] = 0;
      }

    // Add a function called exchangeStars,
    // so 2 users can exchange their star tokens...
    // Do not worry about the price,
    // just write code to exchange stars between users.
    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
        //Check Owner
        require(ownerOf(_tokenId1) == msg.sender);

        //Get Addresses
        address star1Owner = ownerOf(_tokenId1);
        address star2Owner = ownerOf(_tokenId2);

        //Remove
        _removeTokenFrom(star1Owner, _tokenId1);
        _removeTokenFrom(star2Owner, _tokenId2);

        // It is recommended that you use specialized functions for transferring tokens
        // like the safeTransferFrom from ERC721

        //Exchnaged
        _addTokenTo(star1Owner, _tokenId2);
        _addTokenTo(star2Owner, _tokenId1);

    }

    // Write a function to Transfer a Star.
    // The function should transfer a star from the address of the caller.
    // The function should accept 2 arguments,
    // the address to transfer the star to, and the token ID of the star.
    function transferStar(address _receiver, uint256 _tokenId) public {
        //Check Owner
        require(ownerOf(_tokenId) == msg.sender);

        //Remove
        _removeTokenFrom(msg.sender, _tokenId);

        //Transfer
        _addTokenTo(_receiver, _tokenId);

    }

}
