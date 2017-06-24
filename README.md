## First Try at GraphQL & Apollo
Recently, I saw a news said that [GitHub migrated their API from REST to GraphQL](https://developer.github.com/v4/guides/migrating-from-rest/).
This makes me really curious about what's GraphQL and how can it achieve.

### Introduction
[GraphQL](http://graphql.org) is a new API design paradigm open-sourced by Facebook in 2015 but has been powering their mobile apps since 2012.
It eliminates many of the inefficiencies with today’s REST API.
In contrast to REST, GraphQL APIs only expose a single endpoint and the consumer of the API can specify precisely what data they need.
In iOS development, we can take the advantages of the [Apollo iOS client](https://github.com/apollographql/apollo-ios) to execute queries and mutations against a GraphQL server and returns results as query-specific Swift types.
This means you don’t have to deal with parsing JSON, or passing around dictionaries and making clients cast values to the right type manually.
You also don't have to write model types yourself, because these are generated from the GraphQL definitions your UI uses.

### Why GraphQL?
REST APIs expose multiple endpoints where each endpoint returns specific information.
For example, I have the following two endpoints:

1. /classes: Returns a list of classes.
2. /classes/id/students: Returns a list of students who attend this class.

Now, if I would like to display a list of all classes and two students who attend this class. There are two options:

1. Modify the existing API so the response contains two students' information within each class.
2. Call /classes/id/students multiple times in order to obtain the information I want.

Neither of them is a good solution because it will be difficult to scale in the future.
However, I am able to simply specify my data requirements in a single request with GraphQL.
The response will contain an array of classes as well as two students.

### Prerequisite
In this article, I would like to implement a very simple app which displays a list of classes as well as the teacher and the students in that class.
However, there are still several things should be done before we start.

First of all, it is necessary to have a GraphQL server and [Graphcool](https://www.graph.cool) is a perfect choice.
Visit the website and follow the instructions to create a project called Schedule. Then, add the following code into the Graphcool Console to create the necessary schema.
```
type Class implements Node {
  id: ID! @isUnique
  title: String!
  createdAt: DateTime!
  updatedAt: DateTime!
  teacher: Teacher @relation(name: "Teacher")
  students: [Student!]! @relation(name: "Students")
}

type Teacher implements Node {
  id: ID! @isUnique
  name: String!
  class: Class @relation(name: "Teacher")
  createdAt: DateTime!
  updatedAt: DateTime!
}

type Student implements Node {
  id: ID! @isUnique
  name: String!
  class: Class @relation(name: "Students")
  createdAt: DateTime!
  updatedAt: DateTime!
}
```
Remember to save the Simple API for later usage.

![SimpleAPI](https://github.com/ShengHuaWu/Schedule/blob/master/Resources/SimpleAPI.png)

Since I only allow my app to query the data from my server, I need some initial data before implementing the app.
Copy and paste the Simple API into the address bar of any browser and this will open the GraphQL Playground and it allows me to create the initial data.
Write the following three functions and use the play button to create classes, teachers, and students.
```
mutation createClass {
  createClass(title: "Class_Title") {
    id
  }
}

mutation createStudent {
  createStudent(name: "Student_Name") {
    id
  }
}

mutation createTeacher {
  createTeacher(name: "Teacher_Name") {
    id
  }
}
```

![PlayButton](https://github.com/ShengHuaWu/Schedule/blob/master/Resources/PlayButton.png)

Then, use the Playground again to add the teacher and the students into classes via the following functions.
```
mutation attendClass($classID: ID!, $studentID: ID!) {
  addToStudents(classClassId: $classID, studentsStudentId: $studentID) {
    classClass {
      id
      students {
        id
      }
    }
  }
}

mutation teachClass($classID: ID!, $teacherID: ID!) {
  setTeacher(classClassId: $classID, teacherTeacherId: $teacherID) {
    classClass {
      id
      teacher {
        id
      }
    }
  }
}
```

Next thing to do is to configure Xcode and set up the Apollo iOS client.
As mentioned before, the Apollo iOS client features static type generation.
This means that I don’t have to write the model types.
Instead, the Apollo iOS client uses the information from my GraphQL queries to generate the Swift types.
However, I have to go through some configuration steps at first.
Create a new Xcode project called Schedule and install the Apollo iOS client via Carthage.
After that, Install apollo-codegen by typing `npm install -g apollo-codegen` in my Terminal.
Then, create a New Run Script Phase in the Schedule target and copy the following code snippet into the field.
```
APOLLO_FRAMEWORK_PATH="$(eval find $FRAMEWORK_SEARCH_PATHS -name "Apollo.framework" -maxdepth 1)"

if [ -z "$APOLLO_FRAMEWORK_PATH" ]; then
echo "error: Couldn't find Apollo.framework in FRAMEWORK_SEARCH_PATHS; make sure to add the framework to your project."
exit 1
fi

cd "${SRCROOT}/${TARGET_NAME}"
$APOLLO_FRAMEWORK_PATH/check-and-run-apollo-codegen.sh generate $(find . -name '*.graphql') --schema schema.json --output API.swift
```
Remember to drag and drop the build phase to be above the Compile Sources.

![BuildPhase](https://github.com/ShengHuaWu/Schedule/blob/master/Resources/BuildPhase.png)

The final step is to generate the `schema.json` file via typing `apollo-codegen download-schema My_Simple_API --output schema.json` in the Terminal and move the `schema.json` file into the directory where `AppDelegate.swift` is located.

### Implementation
After the long setup procedure, let's start to write some code.
First of all, instantiate the `ApolloClient` within the `AppDelegate.swift` file.
```
let graphQLEndpoint = "My_Simple_API"
let apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)
```
After that, create an empty file in the project, name it `ClassList.graphql`, and add the following code into the file in order to define the query of a list of classes.
```
fragment TeacherDetails on Teacher {
    id
    name
}

fragment ClassDetails on Class {
    id
    title
    teacher {
        ...TeacherDetails
    }
    _studentsMeta {
        count
    }
}

query AllClasses {
    allClasses {
        ...ClassDetails
    }
}
```
Then, build the project and `apollo-codegen` will find this code and generate a Swift representation.
The first time `apollo-codegen` runs, it creates a new file in the root directory of the project named `API.swift`.
All subsequent invocations will just update the existing file.
The generated `API.swift` file is located in the root directory of the project, but it is still necessary to add it to the project.
Drag and drop it into the project and make sure to uncheck the Copy items if needed checkbox.

![APIFile](https://github.com/ShengHuaWu/Schedule/blob/master/Resources/APIFile.png)

The `API.swift` file contains the `AllClassesQuery` class and its corresponding structs. Now, I am able to leverage the `ApolloClient` to fetch the class list as the following.
```
let allClassesQuery = AllClassesQuery()
apollo.fetch(query: allClassesQuery) { (result, error) in
    guard let classes = result?.data?.allClasses else { return }

    let classDetails = classes.map { $0.fragments.classDetails }
    // ...
}
```
The next step is to create `ClassDetails.graphql` file, in order to fetch the teacher and students in each class.
Add the following code into the `ClassDetails.graphql` file.
```
fragment StudentDetails on Student {
    id
    name
}

fragment ClassDetailsWithStudents on Class {
    id
    title
    teacher {
        ...TeacherDetails
    }
    students {
        ...StudentDetails
    }
}

query ClassDetails($classID: ID!) {
    class: Class(id: $classID) {
        ...ClassDetailsWithStudents
    }
}
```
After building the project, the `ClassDetailsQuery` class and its corresponding structs will be generated, and I can take the similar approach to fetch the teacher and students information as well.
```
let classDetailsQuery = ClassDetailsQuery(classId: classID)
apollo.fetch(query: classDetailsQuery) { (result, error) in
    guard let classDetailsWithStudents = result?.data?.class?.fragments.classDetailsWithStudents else { return }

    // ...
}
```

### Conclusion
[Here](https://github.com/ShengHuaWu/Schedule) is the entire sample project.
