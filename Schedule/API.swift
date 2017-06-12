//  This file was automatically generated and should not be edited.

import Apollo

public final class AllClassesQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllClasses {" +
    "  allClasses {" +
    "    __typename" +
    "    id" +
    "    title" +
    "  }" +
    "}"
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let allClasses: [AllClass]

    public init(reader: GraphQLResultReader) throws {
      allClasses = try reader.list(for: Field(responseName: "allClasses"))
    }

    public struct AllClass: GraphQLMappable {
      public let __typename: String
      public let id: GraphQLID
      public let title: String

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        id = try reader.value(for: Field(responseName: "id"))
        title = try reader.value(for: Field(responseName: "title"))
      }
    }
  }
}