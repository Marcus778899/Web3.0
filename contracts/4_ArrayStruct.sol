// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

struct Student{
    uint256 id;
    uint256 score; 
}

contract StructStudent{

    Student student = student;

    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }

    function initStudent3() external {
        student = Student(3, 90);
    }

    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }

}