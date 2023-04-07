defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, term} | {:error, term}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      @impl DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    %{dot | opacity: dot.opacity / 2}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def init([velocity: velocity] = opts) when is_number(velocity), do: {:ok, opts}
  @impl DancingDots.Animation
  def init(opts),
    do:
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}

  @impl DancingDots.Animation
  def handle_frame(dot, 1, _), do: dot
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, velocity: v),
    do: %{dot | radius: dot.radius + v * (frame_number - 1)}
end
