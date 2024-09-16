// SPDX-License-Identifier: MIT
// Author: Kelvin Mulei
pragma solidity ^0.8.0;

contract IdentityVerification {

    // Store user information using struct
    struct Identity {
        string fullName; 
        string nationalID;
        string passportNumber; 
        string email; 
        bool verified;
    }
   
    // Map address with identity
    mapping(address => Identity) public identities;
    address public admin;
    event IdentityVerified(address indexed user);

    // msg.sender is given exclusive admin privileges
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Function to register user details
    function registerIdentity(
        string memory _fullName, 
        string memory _nationalID, 
        string memory _passportNumber, 
        string memory _email
    ) public {
        identities[msg.sender] = Identity({
            fullName: _fullName,
            nationalID: _nationalID,
            passportNumber: _passportNumber,
            email: _email,
            verified: false
        });
    }

    // Function to verify identity
    function verifyIdentity(address _user) public onlyAdmin {
        require(identities[_user].verified == false, "User is already verified.");
        identities[_user].verified = true;
        emit IdentityVerified(_user);
    }

    // Function to check verification status
    function isVerified(address _user) public view returns (bool) {
        return identities[_user].verified;
    }

    // Function to update admin address
    function updateAdmin(address _newAdmin) public onlyAdmin {
        require(_newAdmin != address(0), "Invalid address");
        admin = _newAdmin;
    }
}
