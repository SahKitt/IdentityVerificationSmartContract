// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityVerification {
    // Updated Identity struct to include passport number
    struct Identity {
        string fullName;
        string nationalID;  // National ID
        string passportNumber; // Passport number
        string email;
        bool verified;
    }

    mapping(address => Identity) public identities;
    event IdentityVerified(address indexed user);

    // Updated registerIdentity function to accept passport number as an alternative
    function registerIdentity(
        string memory _fullName, 
        string memory _nationalID, 
        string memory _passportNumber,  // New passport number parameter
        string memory _email
    ) public {
        identities[msg.sender] = Identity({
            fullName: _fullName,
            nationalID: _nationalID,
            passportNumber: _passportNumber, // Store passport number
            email: _email,
            verified: false
        });
    }

    function verifyIdentity(address _user) public {
        require(identities[_user].verified == false, "User is already verified.");
        identities[_user].verified = true;
        emit IdentityVerified(_user);
    }

    function isVerified(address _user) public view returns (bool) {
        return identities[_user].verified;
    }
}