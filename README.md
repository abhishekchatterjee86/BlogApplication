# BlogApplication
This sample app renders different blog articles.

List of all articles.
List of all users in the system.
User details

Core data is used to persist the data locally.

# App Architecture
The app is built using MVVM, Clean Architecture and Redux patterns. 

1. Domain Layer (Business logic) is the inner-most layer (without dependencies to other layers). It contains Entities(Business Models), Use Cases, and Repository Interfaces.

2. Presentation Layer contains UI (UIViewControllers). Views are coordinated by ViewModels which execute one or many Use Cases. Presentation Layer depends only on the Domain Layer.

3. Data Layer contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources.
