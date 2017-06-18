//  This file was automatically generated and should not be edited.

import Apollo

public final class ClassDetailsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query ClassDetails($classID: ID!) {" +
    "  class: Class(id: $classID) {" +
    "    __typename" +
    "    ...ClassDetailsWithStudents" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ClassDetailsWithStudents.fragmentDefinition).appending(TeacherDetails.fragmentDefinition).appending(StudentDetails.fragmentDefinition)

  public let classId: GraphQLID

  public init(classId: GraphQLID) {
    self.classId = classId
  }

  public var variables: GraphQLMap? {
    return ["classID": classId]
  }

  public struct Data: GraphQLMappable {
    public let `class`: Class?

    public init(reader: GraphQLResultReader) throws {
      `class` = try reader.optionalValue(for: Field(responseName: "class", fieldName: "Class", arguments: ["id": reader.variables["classID"]]))
    }

    public struct Class: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let classDetailsWithStudents = try ClassDetailsWithStudents(reader: reader)
        fragments = Fragments(classDetailsWithStudents: classDetailsWithStudents)
      }

      public struct Fragments {
        public let classDetailsWithStudents: ClassDetailsWithStudents
      }
    }
  }
}

public final class AllClassesQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllClasses {" +
    "  allClasses {" +
    "    __typename" +
    "    ...ClassDetails" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(ClassDetails.fragmentDefinition).appending(TeacherDetails.fragmentDefinition)
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let allClasses: [AllClass]

    public init(reader: GraphQLResultReader) throws {
      allClasses = try reader.list(for: Field(responseName: "allClasses"))
    }

    public struct AllClass: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let classDetails = try ClassDetails(reader: reader)
        fragments = Fragments(classDetails: classDetails)
      }

      public struct Fragments {
        public let classDetails: ClassDetails
      }
    }
  }
}

public struct StudentDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment StudentDetails on Student {" +
    "  __typename" +
    "  id" +
    "  name" +
    "}"

  public static let possibleTypes = ["Student"]

  public let __typename: String
  public let id: GraphQLID
  public let name: String

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    name = try reader.value(for: Field(responseName: "name"))
  }
}

public struct ClassDetailsWithStudents: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment ClassDetailsWithStudents on Class {" +
    "  __typename" +
    "  id" +
    "  title" +
    "  teacher {" +
    "    __typename" +
    "    ...TeacherDetails" +
    "  }" +
    "  students {" +
    "    __typename" +
    "    ...StudentDetails" +
    "  }" +
    "}"

  public static let possibleTypes = ["Class"]

  public let __typename: String
  public let id: GraphQLID
  public let title: String
  public let teacher: Teacher?
  public let students: [Student]?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    title = try reader.value(for: Field(responseName: "title"))
    teacher = try reader.optionalValue(for: Field(responseName: "teacher"))
    students = try reader.optionalList(for: Field(responseName: "students"))
  }

  public struct Teacher: GraphQLMappable {
    public let __typename: String

    public let fragments: Fragments

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))

      let teacherDetails = try TeacherDetails(reader: reader)
      fragments = Fragments(teacherDetails: teacherDetails)
    }

    public struct Fragments {
      public let teacherDetails: TeacherDetails
    }
  }

  public struct Student: GraphQLMappable {
    public let __typename: String

    public let fragments: Fragments

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))

      let studentDetails = try StudentDetails(reader: reader)
      fragments = Fragments(studentDetails: studentDetails)
    }

    public struct Fragments {
      public let studentDetails: StudentDetails
    }
  }
}

public struct TeacherDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment TeacherDetails on Teacher {" +
    "  __typename" +
    "  id" +
    "  name" +
    "}"

  public static let possibleTypes = ["Teacher"]

  public let __typename: String
  public let id: GraphQLID
  public let name: String

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    name = try reader.value(for: Field(responseName: "name"))
  }
}

public struct ClassDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment ClassDetails on Class {" +
    "  __typename" +
    "  id" +
    "  title" +
    "  teacher {" +
    "    __typename" +
    "    ...TeacherDetails" +
    "  }" +
    "  _studentsMeta {" +
    "    __typename" +
    "    count" +
    "  }" +
    "}"

  public static let possibleTypes = ["Class"]

  public let __typename: String
  public let id: GraphQLID
  public let title: String
  public let teacher: Teacher?
  /// Meta information about the query.
  public let studentsMeta: StudentsMetum

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    title = try reader.value(for: Field(responseName: "title"))
    teacher = try reader.optionalValue(for: Field(responseName: "teacher"))
    studentsMeta = try reader.value(for: Field(responseName: "_studentsMeta"))
  }

  public struct Teacher: GraphQLMappable {
    public let __typename: String

    public let fragments: Fragments

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))

      let teacherDetails = try TeacherDetails(reader: reader)
      fragments = Fragments(teacherDetails: teacherDetails)
    }

    public struct Fragments {
      public let teacherDetails: TeacherDetails
    }
  }

  public struct StudentsMetum: GraphQLMappable {
    public let __typename: String
    public let count: Int

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      count = try reader.value(for: Field(responseName: "count"))
    }
  }
}