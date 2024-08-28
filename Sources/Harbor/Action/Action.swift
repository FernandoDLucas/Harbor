//
//  File.swift
//  
//
//  Created by Fernando de Lucas da Silva Gomes on 04/08/24.
//  
//  LinkedIn: https://www.linkedin.com/in/fernandodelucas/
//

/// Describe the return action for a function
public enum Action {

    /// Assigns the value that the function should return on the next call, the return is adapted to the type of function expected by the caller.
    /// If the function expects a `Result`, then the deployment will return the value in the `.success` case.
    case deploy(Any?)
 
    /// Assigns the error that the function should return on the next call, the return is adapted to the type of function expected by the caller.
    /// If the function expects a `Result`, then the deployment will return the error in the `.failure` case.
    /// If the function is a throwing function, then the error will be `throw`.
    case anchor(Error?)

}
