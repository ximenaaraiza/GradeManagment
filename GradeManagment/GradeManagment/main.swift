//
//  main.swift
//  GradeManagment
//
//  Created by StudentAM on 1/29/24.
//

import Foundation

//print("Hello, World!")
let filePath = "/Users/studentam/desktop/grades.txt"
//create array of strings to hold the student names and grades
var studentNames : [String] = []
var studentGrades : [[String]] = []
//create array to hold final grade of each student
var finalGrades : [Double] = []
var listedGrades: [String]


do{
    //this will make the entire data in file a string
    let data = try String(contentsOfFile: filePath)
    //then its dividing it line by line
    let studentData = data.split(separator: "\n")
    // then divide the the grades and names into seperate stings by using , as the seperator
    for str in studentData{
        let individualData = str.split(separator: ",")
        //calling manage data to sperate names from grades
        manageData(row: individualData)
     }
    //runs the grad manager that will run all funsctions
    gradeManager()
  

}
catch{
    print("Error reading the \(filePath) file!")
}

//see line 28 for function
func manageData (row: [Substring]){
    var tempGrades: [String] = []
    for info in row.indices{
        if info == 0{
            studentNames.append(String(row[info]))
        }
        if info != 0{
            tempGrades.append(String(row[info]))
        }
    }
    studentGrades.append(tempGrades)
    singleStudentFinalGrade(studentGrades: tempGrades)
   
}

func gradeManager(){
    //string will store the input to know the option (keeps track of option) this will allow you to use your while loop
    var userChoice : String = "0"
    //will have grade manager to keep running and displaying options after already going through one opetion as long as its not quit
    while userChoice != "9"{
        print("What would you like to do? (Enter the number):")
        print("1.Display grade of a single student")
        print("2.Display all grades for student")
        print("3.Display all grades of All students")
        print("4.Find the average grade of the class")
        print("5.Find the average grade of an assignment")
        print("6.Find the lowest grade in the class")
        print("7.Find the highest grade of the class")
        print("8.Filter students by grade range")
        print("9.Quit")
    if let userInput = readLine(){
            //if they enter 1 as input will take them to displayTotal Grade function, will do the same for input 2-8 to the pair function
            if userInput == "1"{
                displayTotalGrade()
            }
            if userInput == "2"{
                allGradesOfOneStudent()
            }
            if userInput == "3"{
                displayEveryOnesGrade()
            }
            if userInput == "4"{
                classAverage()
            }
            if userInput == "5"{
                assignmentAverage()
            }
            if userInput == "6"{
                lowestGrade()
            }
            if userInput == "7"{
                highestGrade()
            }
            if userInput == "8"{
                filter()
            }
        //adds the input to the varibale at the top
           userChoice = userInput
        }
    }
}

func allGradesOfOneStudent(){
    print("Which student would you like to choose?")
    //if the input name if equal to a string in the student names array then print the student grade string
     if let userInput = readLine(){
        for i in studentNames.indices{
            print(studentNames[i])
            if studentNames[i].lowercased() == userInput.lowercased(){
                print(studentGrades[i])
            }
        }
    }
}
    //this will add all the grades for a student in a string together in order to create totoal points earned
func singleStudentFinalGrade(studentGrades:[String]){
    var sum: Int = 0
    for everyGrade in studentGrades{
        if let IntGrade = Int(everyGrade){
            sum += IntGrade
        }
    }
    //this will didvide the total amount of points by the amount of assignments to create the final grade them put it in your array of doubles at the begining
    let totalGrade = sum/studentGrades.count
    finalGrades.append(Double(totalGrade))
}

func displayTotalGrade(){
    print("Which student would you like to choose?")
    // this will read the name input and match it to a string in the array and pull the same indice in the final grades to display it
     if let userInput = readLine(){
        for i in studentNames.indices{
            if studentNames[i].lowercased() == userInput.lowercased(){
                print(finalGrades[i])
            }
        }
    }
}

//this will take every name and its indice and will pair it with the indice of the strings of grades and print it with the : the bottom will also make it so each student and thier grades has their own line
func displayEveryOnesGrade(){
    for i in studentNames.indices{
        print(studentNames[i] + "'s grades are: ", terminator:"")
        for grade in studentGrades[i]{
            print(grade + ", ", terminator:"")
        }
        print()
    }

}

// this function will find the class average for every single grade in the final grades array youll add them all together
func classAverage(){
    var sum : Double = 0
    for grade in finalGrades{
        sum += grade
    }
    //then divide the total by the amount of students thats why you count the lenths of the array
    let classAv = sum/Double(finalGrades.count)
    print("The class average is: \(String(format: "%.2f",classAv))")
}

// this will find the average of an assigment depending on the input
func assignmentAverage(){
 print("which assignment would you like to finde the average of (1-10)")//
    var sum : Double = 0
    var index : Int = 0
    var assignAv : Double = 0

    if let userInput = readLine(), let userIndex = Int(userInput){
        for indGrades in studentGrades{
                index = userIndex
            if let chosenGrade = Double(indGrades[index-1]){
                sum += chosenGrade
            }
        }
        let average : Double  = sum/Double(studentNames.count)
        assignAv = average
    }
    print("The average for assignement #\(index) is \(String(format: "%.2f", assignAv))")
}

func highestGrade(){
    //leave the highest grade set as the first grade
    var highest : Double = finalGrades[0]
    var index : Int = 0
    //make a comparison between whats in the varibale and the next grade in final grades if the greater than then replace and keep comparing
    for grade in finalGrades.indices{
        if finalGrades[grade] > highest{
            (highest) = finalGrades[grade]
            index = grade
        }
    }
    print("\(studentNames[index]) is the student with the lowest grade \(String(format: "%.2f", highest))")
}


func lowestGrade(){
    //leave the lowest as the fist grade
    let lowest : Double = finalGrades[0]
    var index : Int = 0
    //make a comparison if the grade and lowest and the next grade are less if its lower replace lowest and keep comparing next number
    for grade in finalGrades.indices{
        if finalGrades[grade] < lowest{
            //then nmake the index the grade so it know the assignment number to return
            index=grade
        }
    }
    print("\(studentNames[index]) is the student with the lowest grade \(String(format:"%.2f", lowest)) ")
}


func filter(){
    //checks to find thw lowest in the final grades and pulls the array of grades in the same indice and the name in that indice to sisplay
    print ("Enter the low range you would like to use?")
    if let userInput = readLine(), let lowRange = Double(userInput){
        print("Enter the high range you would like to use?")
        if let userInput = readLine(), let highRange = Double(userInput){
            for gradeRange in finalGrades.indices{
                if finalGrades[gradeRange] > lowRange && finalGrades[gradeRange] < highRange{
                    print ("\(studentNames[gradeRange]): \(finalGrades[gradeRange])")
                }
               
            }
        }
    }
}
