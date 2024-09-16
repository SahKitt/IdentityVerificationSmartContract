// SPDX-License-Identifier: MIT
// Author:Kelvin Mulei
pragma solidity ^0.8.0;

contract IdentityVerification {

//    //store user information using struct
    struct Identity {
        bytes32 fullName; 
        bytes32 nationalID;
        bytes32 passportNumber; 
        bytes32 email; 
        bool verified;
    }
   
//    //map address with identity
    mapping(address => Identity) public identities;
    address public admin;
    event IdentityVerified(address indexed user);

// //msg.sender is given exclussive admin privileges
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

//    ////function to register user details
    function registerIdentity(
        bytes32 _fullName, 
        bytes32 _nationalID, 
        bytes32 _passportNumber, 
        bytes32 _email
    ) public {
        identities[msg.sender] = Identity({
            fullName: _fullName,
            nationalID: _nationalID,
            passportNumber: _passportNumber,
            email: _email,
            verified: false
        });
    }

// ///function to verify identity

    function verifyIdentity(address _user) public onlyAdmin {
        require(identities[_user].verified == false, "User is already verified.");
        identities[_user].verified = true;
        emit IdentityVerified(_user);
    }

// /////function to check verification status
    function isVerified(address _user) public view returns (bool) {
        return identities[_user].verified;
    }

   
    function updateAdmin(address _newAdmin) public onlyAdmin {
        require(_newAdmin != address(0), "Invalid address");
        admin = _newAdmin;
    }
}
