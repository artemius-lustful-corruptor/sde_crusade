defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(context) do
      case context do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: #{context}"}
      end
    end
  end

  def divide(list) when length(list) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _two]), do: raise(DivisionByZeroError)
  def divide([one, two]), do: div(two, one)
end
