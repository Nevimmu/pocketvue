<script setup lang="ts">
import { RouterLink } from 'vue-router'

defineProps({
	name: {
		type: String,
		required: true,
	},
	to: {
		type: String,
		required: true,
	},
	icon: {
		type: String,
		required: false,
		default: null,
	},
})
</script>

<template>
	<RouterLink :to="to" active-class="is-active">
		<template v-if="icon">
			<span class="icon-text">
				<span class="icon">
					<i :class="icon"></i>
				</span>
				<span>{{ name }}</span>
			</span>
		</template>
		<template v-else>
			{{ name }}
		</template>
	</RouterLink>
</template>
