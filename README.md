# Devise and Pundit Lab

## Objectives

We're going to learn how to integrate Pundit into a Rails application.  For our
data model, we're going to use a secret notes message board.

## Data model

We're going to have `User`s, `Note`s, and a `Viewer`s join table, which gives
`User`s read access to `Note`s.

## Instructions

The lab comes with a Rails skeleton with the Devise and Pundit gems defined in
the `Gemfile`. Run `bundle install` to make sure the dependencies are
installed.

1. Add a "role" field to the `User` model through a migration
1. Add a role `enum` to the user model.
2. Write a policy governing the `User` model. Ensure all policy specs pass.
3. Add authentication and authorization filters to your `UsersController`.
   Ensure that only administrators can update or destroy users.

We've included the relevant models/controllers and views from the CanCanCan lab
so you don't have to rebuild them.

# Note

If you launch the app in the browser in its starting state it will throw an
error. This occurs because certain things the code depends on, like
`current_user`, are no lot initially functional.

You'll need to start implementing devise to boot the app up in the browser.

Follow the tests.

**Hints**

* Some tests might require you adding the flash to a layout.
* If you use all the Devise modules you will run into problems. Use only the ones you need.
* Use the `User` policy as a guide

## Stretch

Write a spec for the NotePolicy class, then write the NotePolicy class. You
should ensure that:

  * Normal users can:
    * Create notes owned by them
    * Edit their own posts
    * Delete their own posts
    * Add viewers to their own posts
    * Remove viewers from their own posts
    * See notes they're viewers of
    * See their own notes
  * Moderators can:
    * See all notes.
  * Admins can:
    * Perform any action on a user or a note.

Once your policy spec is written and passes, write feature specs for creating,
reading, and updating notes. You can copy the feature specs that currently
exist for updating and deleting users.

## References

* [Pundit]

[Pundit]: https://github.com/elabs/pundit

