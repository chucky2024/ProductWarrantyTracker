// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract WarrantyTracker {
    struct Product {
        string name;
        uint256 warrantyExpiry;
        address owner;
        bool exists;
    }

    mapping(bytes32 => Product) public products;

    event ProductRegistered(bytes32 indexed productId, string name, uint256 warrantyExpiry, address indexed owner);
    event WarrantyClaimed(bytes32 indexed productId);

    function registerProduct(bytes32 productId, string memory name, uint256 warrantyPeriod) public {
        products[productId] = Product(name, block.timestamp + warrantyPeriod, msg.sender, true);
        emit ProductRegistered(productId, name, block.timestamp + warrantyPeriod, msg.sender);
    }

    function claimWarranty(bytes32 productId) public {
        require(products[productId].exists, "Product does not exist");
        require(products[productId].owner == msg.sender, "Not the owner");
        require(block.timestamp < products[productId].warrantyExpiry, "Warranty expired");

        emit WarrantyClaimed(productId);
    }

    function getProduct(bytes32 productId) public view returns (string memory, uint256, address) {
        require(products[productId].exists, "Product does not exist");
        return (products[productId].name, products[productId].warrantyExpiry, products[productId].owner);
    }
}
