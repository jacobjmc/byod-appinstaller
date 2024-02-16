<script setup lang="ts">
import { invoke } from "@tauri-apps/api/tauri";
import { onMounted } from "vue";

// call rust function
// const showHello = async () => {
//   hello.value == "hello_test"
//     ? (hello.value = "Click for hello")
//     : (hello.value = (await invoke("hello_world")) as string);
// };

onMounted(async () => {
  await invoke("run_script");
});
</script>

<template>
  <div id="app" class="bg-green-200 h-[200vh]">
    <div class="flex justify-center mx-52 rounded-lg">
      <div class="flex flex-col mt-10 w-full rounded-lg">test</div>
    </div>
  </div>
</template>

<style>
#app {
  color: black;
}
</style>
