<script setup lang="ts">
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'
import {
	Card,
	CardContent,
	CardDescription,
	CardFooter,
	CardHeader,
	CardTitle,
} from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import {
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'

const authStore = useAuthStore()
const router = useRouter()

const formSchema = toTypedSchema(
	z.object({
		email: z.string().email(),
		password: z.string(),
	}),
)

const { handleSubmit, isFieldDirty } = useForm({
	validationSchema: formSchema,
})

const onSubmit = handleSubmit(async (values) => {
	try {
		await authStore.login(values.email, values.password)
		router.push('/')
	} catch (error) {
		console.error(error)
	}
})
</script>

<template>
	<form @submit="onSubmit">
		<Card>
			<CardContent>
				<FormField v-slot="{ componentField }" name="email" :validate-on-blur="!isFieldDirty">
					<FormLabel>Email</FormLabel>
					<FormControl>
						<Input type="email" v-bind="componentField" />
						<ErrorMessage name="email" class="text-red-600" />
					</FormControl>
				</FormField>
				<FormField v-slot="{ componentField }" name="password" :validate-on-blur="!isFieldDirty">
					<FormLabel>Password</FormLabel>
					<FormControl>
						<Input type="password" v-bind="componentField" />
						<ErrorMessage name="password" class="text-red-600" />
					</FormControl>
				</FormField>
			</CardContent>
			<CardFooter class="flex flex-col">
				<p v-if="authStore.error" class="text-red-600 font-bold">Couldn't login</p>
				<Button type="submit" class="cursor-pointer w-full">Login</Button>
			</CardFooter>
		</Card>
	</form>
</template>
