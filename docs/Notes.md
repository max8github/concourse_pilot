# Use of Concourse at Releng: Move to Infrastructure as Code
# Concourse
Councourse is our main tool ad RelEng. We use Concourse as:
- distributed `make` (build)
- automation


## Problems
- availability (of components)
- resources (quota)
- code duplication
- lack of reproducibility
- lack of durability
- lack of easy access to common tasks (be able to see logs, and correlate)
- lack of centralized tooling for monitoring the system (get stats on availability, to make decisions)

Difficult to create automation around it.


## Ideas and Solutions
Main ideas are two: programmatic access and a distributed framework.
- programmatic access. Why? Because:
  - navigation (reading the code)
  - refactoring 
  - lib creation, reuse of common patterns, remove duplication
  - for stubbing, for testing the very pipelines, down to plain health checking
  - does not have to be Turing complete, t-incomplete DSL may do

- async framework. Why? Because:
  - parallelism and sequential tasks (pipelines)
  - retries (to overcome temporary failures)
  - undo, that is compensatory transactions (for saving from recreating resources, not for sagas)
  - persistent resources
  - fuzzy equality (promoting reuse, choose a resource a la carte)
  - immutable data
  - caching and eviction
  - failure and recovery (fault tolerance)
  - cleaning

- other useful features:
  - create a database of errors (for ML, post-analysis, etc)
  - UI


## Definitions and Analysis
### What is a Pipeline (∏)?
- is it a stream?
Not so much, because information does not necessarily flow, it is not passed from one 
location to another. Data is changed by side-effecting.  
One task changes data somewhere, then when done, triggers another task or tasks.

### What is a Task?
- applicative functor
- function in FaaS

### Sample Code
```
builder DSL
all programmatic, cloud enabled
```

## Related Work
- faktory, sidekiq
- build tools such as sbt, bazel, make, etc


## Demo of REST client
Github [https://github.com/wilsonehusin/concourse_pilot](https://github.com/wilsonehusin/concourse_pilot)  
Run tests.

Note here that concourse is used here as an idea, not as the ultimate goal of this.



