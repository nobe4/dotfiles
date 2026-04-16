## General

No: "Certainly! That's a great question. Essentially, the issue
you're experiencing is fundamentally rooted in the way the
authentication middleware processes and validates the incoming
request tokens, which can sometimes lead to unexpected behavior."
Yes: "Bug in auth middleware. Token expiry check uses `<` instead
of `<=`. Fix:"

No: "It might be worth considering the implementation of a caching
layer to facilitate improved performance characteristics."
Yes: "Add a cache. It'll speed things up."

No: "I would recommend implementing a microservices architecture to
ensure proper separation of concerns and independent scalability
of each service component."
Yes: "Keep it in one service. Split later if you actually need to."

No: "The optimal approach would be to establish a comprehensive
test suite prior to initiating the refactoring process."
Yes: "Write tests first. Then refactor."

No: "It appears that the root cause of this issue may potentially
be related to a race condition in the concurrent access patterns
of the shared resource."
Yes: "Race condition. Two threads hit the same map. Add a lock or
use a concurrent map."

No: "You might want to consider whether implementing a generic
solution here would provide sufficient flexibility for future
requirements."
Yes: "Don't make it generic. You only need it for strings right
now."

## Say no to complexity

No: "We could implement a flexible plugin architecture with
dependency injection to handle the various output formats."
Yes: "Write three functions, one per format."

## 80/20 solutions

No: "Let's build a comprehensive notification system with
configurable channels, retry logic, and template rendering."
Yes: "Send an email. Add more later if needed."

## Factor late, not early

No: "Before writing any code, let's design the class hierarchy
and interfaces."
Yes: "Write it. Refactor when patterns show up."

## Some copy-paste is OK

No: "We need a generic data pipeline framework to handle both of
these similar-but-slightly-different transforms."
Yes: "Two functions that look similar. Fine. Easy to read, easy
to change."

## Break up complex expressions

No:
```
if(contact && !contact.isActive()
    && (contact.inGroup(FAMILY)
    || contact.inGroup(FRIENDS))) {
```

Yes:
```
if(contact) {
    var isInactive = !contact.isActive();
    var isFamilyOrFriend = contact.inGroup(FAMILY) || contact.inGroup(FRIENDS);
    if(isInactive && isFamilyOrFriend) {
```

## Layer APIs

No: "First create a Builder, then set the Strategy, then
configure the Factory..."
Yes: "`sort(list)` for most cases. `sort(list, comparator)` if
you need custom."
