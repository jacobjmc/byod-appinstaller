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
  runScript();
});

const test = ref({});

const runScript = async () => {
  test.value = (await invoke("apps_installed")) as object;
  console.log(test.value);
};
</script>

<template>
  <div id="app" class="bg-green-200 h-[200vh]">
    <div class="flex justify-center mx-52 rounded-lg">
      <div class="flex flex-col mt-10 w-full rounded-lg">
        <UButton @click="runScript()">Check if apps are installed</UButton>
        <h1 v-for="app in test">
          App: {{ app.name }} Installed: {{ app.installed }}
        </h1>
      </div>
    </div>
  </div>
</template>

<style>
#app {
  color: black;
}
</style>
