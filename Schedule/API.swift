//  This file was automatically generated and should not be edited.

import Apollo

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
    "}"

  public static let possibleTypes = ["Class"]

  public let __typename: String
  public let id: GraphQLID
  public let title: String
  public let teacher: Teacher?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    title = try reader.value(for: Field(responseName: "title"))
    teacher = try reader.optionalValue(for: Field(responseName: "teacher"))
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
}