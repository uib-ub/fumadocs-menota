import { source } from "@/lib/source"

export type CustomPage = ReturnType<typeof source.getPage> & {
  data: {
    author?: string[],
    date?: Date,
    changeLog: Change[]
  }
}

export type Change = {
  date: Date,
  author: string,
  changes: string[]
}