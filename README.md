# ImmutableProductsExample

This is an experimental project that makes use of immutable structs that shadow underlying CoreData entitites.

The goal of this repository is to experiment and demonstrate that it is possible to take advantage of all of CoreData 
capabilities without ever exposing any of the framework parts to the main project.

The main target interfaces with its underlying storage via a repository protocol - the `ProductRepositoryType`.

That's as much as the main target know about the Persistence framework, which hides the complexities and 
implementation details around CoreData.
