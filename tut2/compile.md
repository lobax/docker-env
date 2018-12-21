# Tutorial 2: Using our enviornment 

Our previous tutorial showed us a simple way use the development enviorment that we crated. However, it isn't very practical - for one there isn't any persistance for any rust applications we build in it.
We also can't really take files in our host system to compile them in our environment. 

In this tutorial, we will look at how we can construct a more practical development enviorment for building rust applications. 

## A basic Rust applciation 

We'll start with a basic rust application. This isn't a tutorial on rust, so we won't do anything fancy, just a simple hello world: 

```rust
fn main() {
    println!("Hello, world!");
}
```

Save it as `hello.rs`. 

## Expanding our Dockerfile

Taking the Dockerfile from the last tutorial as a base, we can expand it with the following: 

```
# Copy over our file 
COPY helloworld.rs app/hello.rs
# Compile our program 
RUN rustc app/hello.rs
```

What this does is construct a new image with our compiled application, using a new `COPY` instruction

### Copy
The `COPY` instruction is rather self explanatory and takes two arguments: 
 - A source path (relative paths are based on the build context) 
 - A destination path

One important fact to note is that if we change any files in our host system, then we will invalidate the cache. This will cause docker to redo all the following steps (which we want in our case).

The is a similar instruction called `ADD` which does the same thing but can handle URLs and automagically unatchive tar-balls. But in order to avoid suprises, stick with `COPY` unless you specifically need `ADD`. 

## Building 

Let's build our new container. For simplicity, lets rename it to "hello": 
`docker build . -t hello`

## Running our application 
We can fire it up by running: `docker run hello sh -c "./hello"`.

You should see the message being printed!

## Moving forward

Now we actually have a workable environment, but it's still a very bloated environment - we have a bunch of packages, dependencies and files that we might have needed to compile rust but that we don't actually need in order to use the rust compiler. 

In later tutorials, we will see how we can use **Multistage builds** in order to alleviate this problem. 
