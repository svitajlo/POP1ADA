with Ada.Text_IO;

procedure Main is
   -- Boolean variable to control thread termination
   Can_Stop : Boolean := False;
   pragma Atomic(Can_Stop);

   -- Type declaration for the main computation thread
   task type Main_Thread;

   -- Body of the main computation thread
   task body Main_Thread is
      Sum : Long_Long_Integer := 0;
   begin
      -- Loop until the termination condition is met
      loop
         Sum := Sum + 1;
         exit when Can_Stop;
      end loop;

      -- Output the thread's ID, sum, and number of elements used
      Ada.Text_IO.Put_Line("Thread: Found sum - " & Sum'Image & ", Number of elements - " & Sum'Image);
   end Main_Thread;

   -- Number of threads to create
   Num_Threads : constant := 4;

   -- Array to hold the thread instances
   type Main_Thread_Array is array(1..Num_Threads) of access Main_Thread;

   -- Variable to iterate over the thread instances
   Threads : Main_Thread_Array;

begin
   -- Create the specified number of threads
   for I in Threads'Range loop
      Threads(I) := new Main_Thread;
   end loop;

   -- Delay for a specified period before allowing threads to stop
   delay 30.0;
   Can_Stop := True;

   -- Wait for each thread to complete before exiting
   for T of Threads loop
      null;
   end loop;

end Main;
