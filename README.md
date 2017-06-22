## First Try at GraphQL & Apollo
Recently, I saw a news said that [GitHub migrated their API from REST to GraphQL](https://developer.github.com/v4/guides/migrating-from-rest/).
This makes me really curious about what's GraphQL and how can it achieve.

### Introduction
[GraphQL](http://graphql.org) is a new API design paradigm open-sourced by Facebook in 2015 but has been powering their mobile apps since 2012.
It eliminates many of the inefficiencies with today’s REST API.
In contrast to REST, GraphQL APIs only expose a single endpoint and the consumer of the API can specify precisely what data they need.
In iOS development, we can take the advantages of [Apollo iOS client](https://github.com/apollographql/apollo-ios) to execute queries and mutations against a GraphQL server and returns results as query-specific Swift types.
This means you don’t have to deal with parsing JSON, or passing around dictionaries and making clients cast values to the right type manually.
You also don't have to write model types yourself, because these are generated from the GraphQL definitions your UI uses.

### Why GraphQL?
REST APIs expose multiple endpoints where each endpoint returns specific information.
For example, I have the following two endpoints:

1. /classes: Returns a list of classes.
2. /classes/id/students: Returns a list of students who attend this class.

Now, if I would like to display a list of all classes and three students who attend this class. There are two options:

1. Modify the existing API so the response contains three students' information within each class.
2. Call /classes/id/students multiple times in order to obtain the information I want.

Neither of them is a good solution because it will be difficult to scale in the future.

### Prerequisite
1. Installation
2. Seed data in playground
3. Dependency management

### Implementation
1. Class & metadata
2. Teacher & students

### Conclusion
