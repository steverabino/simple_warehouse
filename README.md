# Simple Warehouse

## Requirements

I started with a modular view of crates:

e.g a 2 x 2 crate on a 2 x 3 shelving unit would take up four different shelves and the following would happen:

- `locate` would return 4 different locations for the 2 x 2 crate

```
> view
 |   |   |   |
1|   | P | P |
 |___|___|___|
 |   |   |   |
0|   | P | P |
 |___|___|___|
   0   1   2
> locate P
[1, 0], [2, 0], [1, 1], [2, 1] 
```

- `remove` would remove the single X, Y coordinate given, leaving 3 crates within the shelving unit

```
> remove 2 1
> view
 |   |   |   |
1|   | P |   |
 |___|___|___|
 |   |   |   |
0|   | P | P |
 |___|___|___|
   0   1   2 
```

The above implementation is saved as branch `crates-as-individual-units` if you would like to see it in action!

However, on further scruntinisation of the requirements, I changed to a different view of the requirements, which treats crates as variable-sized entities, and act as a unit, even when in the shelving unit:

e.g a 2 x 2 "crate" on a 2 x 3 "shelving unit" would take up one location of the shelves, and the following would happen:

- `locate` would return only 1 location for the 2 x 2 crate

```
> view
 |   |   |   |
1|   | P | P |
 |___|___|___|
 |   |   |   |
0|   | P | P |
 |___|___|___|
   0   1   2
> locate P
[1, 0] 
```

- `remove` would remove the entire crate at the coordinates given (even if it is not the "origin" coordinates of the crate, leaving nothing left in this shelving unit. The removal confirmation message includes both the coordinates the user gives, and the "origin" coordinates of the crate.

```
> remove 0 1 OR remove 2 1
> view
 |   |   |   |
1|   |   |   |
 |___|___|___|
 |   |   |   |
0|   |   |   |
 |___|___|___|
   0   1   2 
```

Because of the approach taken below, and by having a thorough test suite, this actually was a very simple change to make.

## Key Design Decisions

The app is split into the App, Models and Services in an attempt to adhere to the Single Responsibility Principle, each class should do only do one thing.

### App

The app is run from `simple_warehouse.rb`; I have separated out the code that interprets commands out from the code which prompts the user, so that the interpretation of commands can be easily tested.

There is a feature in this file which changes whether the output is printed to screen or just held in a variable depending on whether `ENV['testmode']` is true; the test suite sets this to true so test output is not littered with printed output.

### Models

The models are `Shelving Unit`, which represents the rack of shelves (`Rack` is a protected namespace in Ruby), and `Crate`, which represent a single crate.

The models tend to only hold information about the thing they represent. An exception to this is the Shelving Unit model's print to screen method, which is included as it relies only on the information of the Shelving Unit, but delegates the actual work to the `print shelving unit` service.

### Services

The services tend to model one action that can be performed on the models. There is a service to `store crates`, `locate crates`, `remove crates`, and `print shelving unit`.

## Tests

The full test suite can be run by `rake test` from the command line. Each model, service, and the `simple_warehouse.rb` file all have a corresponding test file.

## Improvements to be made

- Ability to validate input
- Add column/row numbers to printout of shelving rack (e.g. as I've done above in the readme)
- Tests to make use of shared objects (fixtures), as they each use their own setup methods, which is causing a lot of repetition in the testing code.





